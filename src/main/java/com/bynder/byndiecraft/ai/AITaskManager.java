package com.bynder.byndiecraft.ai;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.ai.models.JiraTicket;
import com.bynder.byndiecraft.ai.models.PRResult;
import com.bynder.byndiecraft.jira.JiraClient;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import okhttp3.*;
import org.bukkit.entity.Player;
import org.bukkit.inventory.ItemStack;

import java.io.IOException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;

public class AITaskManager {
    private final ByndiecraftPlugin plugin;
    private final JiraClient jiraClient;
    private final OkHttpClient httpClient;
    private final Gson gson;
    private final String mcpEndpoint;

    public AITaskManager(ByndiecraftPlugin plugin, JiraClient jiraClient) {
        this.plugin = plugin;
        this.jiraClient = jiraClient;
        this.httpClient = new OkHttpClient.Builder()
                .connectTimeout(30, TimeUnit.SECONDS)
                .readTimeout(120, TimeUnit.SECONDS)
                .writeTimeout(30, TimeUnit.SECONDS)
                .build();
        this.gson = new Gson();
        this.mcpEndpoint = plugin.getConfig().getString("ai.mcp_endpoint", "http://localhost:3000/implement-ticket");
    }

    public CompletableFuture<PRResult> implementTicket(Player player, String ticketKey, ItemStack book) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                plugin.getLogger().info(String.format("[AITask] Starting implementation for ticket: %s", ticketKey));

                // 1. Fetch full ticket details from Jira
                com.bynder.byndiecraft.jira.JiraTicket jiraTicketResult = jiraClient.getIssue(ticketKey).join();
                if (jiraTicketResult == null) {
                    plugin.getLogger().warning(String.format("[AITask] Failed to fetch ticket: %s", ticketKey));
                    return PRResult.failure("Failed to fetch ticket from Jira");
                }

                String summary = jiraTicketResult.getSummary();
                // Note: JiraClient's JiraTicket doesn't have description, we'll need to get it separately
                // For now, use summary as description
                String description = summary;
                String jiraUrl = plugin.getConfig().getString("jira.url") + "/browse/" + ticketKey;

                JiraTicket ticket = new JiraTicket(ticketKey, summary, description, jiraUrl);

                plugin.getLogger().info(String.format("[AITask] Ticket details: %s - %s", ticketKey, summary));

                // 2. Call MCP endpoint
                JsonObject payload = new JsonObject();
                payload.addProperty("ticketKey", ticket.getKey());
                payload.addProperty("ticketSummary", ticket.getSummary());
                payload.addProperty("ticketDescription", ticket.getDescription());
                payload.addProperty("jiraUrl", ticket.getUrl());
                payload.addProperty("playerName", player.getName());

                RequestBody requestBody = RequestBody.create(
                        payload.toString(),
                        MediaType.parse("application/json")
                );

                Request request = new Request.Builder()
                        .url(mcpEndpoint)
                        .post(requestBody)
                        .build();

                plugin.getLogger().info(String.format("[AITask] Calling MCP endpoint: %s", mcpEndpoint));

                try (Response response = httpClient.newCall(request).execute()) {
                    if (!response.isSuccessful()) {
                        String errorBody = response.body() != null ? response.body().string() : "No error details";
                        plugin.getLogger().severe(String.format("[AITask] MCP call failed: %s - %s", response.code(), errorBody));
                        return PRResult.failure("MCP server error: " + response.code());
                    }

                    String responseBody = response.body().string();
                    JsonObject result = gson.fromJson(responseBody, JsonObject.class);

                    if (result.has("success") && result.get("success").getAsBoolean()) {
                        String prUrl = result.get("prUrl").getAsString();
                        String resultSummary = result.has("summary") ? result.get("summary").getAsString() : "Implementation complete";

                        plugin.getLogger().info(String.format("[AITask] Success! PR created: %s", prUrl));
                        return PRResult.success(prUrl, resultSummary);
                    } else {
                        String error = result.has("error") ? result.get("error").getAsString() : "Unknown error";
                        plugin.getLogger().warning(String.format("[AITask] Implementation failed: %s", error));
                        return PRResult.failure(error);
                    }
                }

            } catch (IOException e) {
                plugin.getLogger().severe(String.format("[AITask] Network error: %s", e.getMessage()));
                e.printStackTrace();
                return PRResult.failure("Network error: " + e.getMessage());
            } catch (Exception e) {
                plugin.getLogger().severe(String.format("[AITask] Unexpected error: %s", e.getMessage()));
                e.printStackTrace();
                return PRResult.failure("Unexpected error: " + e.getMessage());
            }
        });
    }
}
