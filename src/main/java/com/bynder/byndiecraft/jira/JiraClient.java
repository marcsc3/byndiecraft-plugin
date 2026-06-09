package com.bynder.byndiecraft.jira;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import okhttp3.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class JiraClient {
    private final String baseUrl;
    private final String authHeader;
    private final OkHttpClient httpClient;
    private final Gson gson;
    private final Logger logger;
    private final boolean debugMode;

    public JiraClient(String baseUrl, String email, String apiToken, Logger logger, boolean debugMode) {
        this.baseUrl = baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
        this.logger = logger;
        this.debugMode = debugMode;
        this.gson = new Gson();

        // Create Basic Auth header
        String credentials = email + ":" + apiToken;
        this.authHeader = "Basic " + Base64.getEncoder().encodeToString(credentials.getBytes());

        // Configure HTTP client with timeouts
        this.httpClient = new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .readTimeout(15, TimeUnit.SECONDS)
                .writeTimeout(15, TimeUnit.SECONDS)
                .build();

        if (debugMode) {
            logger.info("JiraClient initialized for: " + baseUrl);
        }
    }

    public CompletableFuture<JiraTicket> getIssue(String issueKey) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                String url = baseUrl + "/rest/api/3/issue/" + issueKey;
                Request request = new Request.Builder()
                        .url(url)
                        .header("Authorization", authHeader)
                        .header("Accept", "application/json")
                        .get()
                        .build();

                if (debugMode) {
                    logger.info("Fetching issue: " + issueKey);
                }

                try (Response response = httpClient.newCall(request).execute()) {
                    if (!response.isSuccessful()) {
                        logger.warning("Failed to fetch issue " + issueKey + ": " + response.code());
                        return null;
                    }

                    String responseBody = response.body().string();
                    JsonObject json = gson.fromJson(responseBody, JsonObject.class);

                    String key = json.get("key").getAsString();
                    String summary = json.getAsJsonObject("fields").get("summary").getAsString();
                    JsonObject status = json.getAsJsonObject("fields").getAsJsonObject("status");
                    String statusName = status.get("name").getAsString();
                    String statusId = status.get("id").getAsString();

                    if (debugMode) {
                        logger.info("Issue fetched: " + key + " - " + statusName);
                    }

                    return new JiraTicket(key, summary, statusName, statusId);
                }
            } catch (IOException e) {
                logger.severe("Error fetching issue " + issueKey + ": " + e.getMessage());
                return null;
            }
        });
    }

    public CompletableFuture<Map<String, String>> getTransitions(String issueKey) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                String url = baseUrl + "/rest/api/3/issue/" + issueKey + "/transitions";
                Request request = new Request.Builder()
                        .url(url)
                        .header("Authorization", authHeader)
                        .header("Accept", "application/json")
                        .get()
                        .build();

                if (debugMode) {
                    logger.info("Fetching transitions for: " + issueKey);
                }

                try (Response response = httpClient.newCall(request).execute()) {
                    if (!response.isSuccessful()) {
                        logger.warning("Failed to fetch transitions for " + issueKey + ": " + response.code());
                        return new HashMap<>();
                    }

                    String responseBody = response.body().string();
                    JsonObject json = gson.fromJson(responseBody, JsonObject.class);
                    JsonArray transitions = json.getAsJsonArray("transitions");

                    Map<String, String> transitionMap = new HashMap<>();
                    transitions.forEach(element -> {
                        JsonObject transition = element.getAsJsonObject();
                        String id = transition.get("id").getAsString();
                        String name = transition.getAsJsonObject("to").get("name").getAsString();
                        transitionMap.put(name, id);

                        if (debugMode) {
                            logger.info("  Transition: " + name + " (ID: " + id + ")");
                        }
                    });

                    return transitionMap;
                }
            } catch (IOException e) {
                logger.severe("Error fetching transitions for " + issueKey + ": " + e.getMessage());
                return new HashMap<>();
            }
        });
    }

    public CompletableFuture<Boolean> transitionIssue(String issueKey, String targetStatusName) {
        return getTransitions(issueKey).thenCompose(transitions -> {
            String transitionId = transitions.get(targetStatusName);

            if (transitionId == null) {
                logger.warning("No transition found to status: " + targetStatusName + " for issue " + issueKey);
                logger.warning("Available transitions: " + transitions.keySet());
                return CompletableFuture.completedFuture(false);
            }

            return executeTransition(issueKey, transitionId);
        });
    }

    private CompletableFuture<Boolean> executeTransition(String issueKey, String transitionId) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                String url = baseUrl + "/rest/api/3/issue/" + issueKey + "/transitions";

                JsonObject requestBody = new JsonObject();
                JsonObject transition = new JsonObject();
                transition.addProperty("id", transitionId);
                requestBody.add("transition", transition);

                RequestBody body = RequestBody.create(
                        requestBody.toString(),
                        MediaType.parse("application/json")
                );

                Request request = new Request.Builder()
                        .url(url)
                        .header("Authorization", authHeader)
                        .header("Content-Type", "application/json")
                        .post(body)
                        .build();

                if (debugMode) {
                    logger.info("Transitioning " + issueKey + " with transition ID: " + transitionId);
                }

                try (Response response = httpClient.newCall(request).execute()) {
                    boolean success = response.isSuccessful();

                    if (success) {
                        logger.info("Successfully transitioned " + issueKey);
                    } else {
                        String errorBody = response.body() != null ? response.body().string() : "No error details";
                        logger.warning("Failed to transition " + issueKey + ": " + response.code() + " - " + errorBody);
                    }

                    return success;
                }
            } catch (IOException e) {
                logger.severe("Error transitioning issue " + issueKey + ": " + e.getMessage());
                return false;
            }
        });
    }

    public CompletableFuture<List<JiraTicket>> searchIssues(String projectKey) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                String jql = "project = \"" + projectKey + "\" AND sprint in openSprints() ORDER BY status ASC";
                String url = baseUrl + "/rest/api/3/search/jql";

                JsonObject requestJson = new JsonObject();
                requestJson.addProperty("jql", jql);
                requestJson.addProperty("maxResults", 50);
                JsonArray fieldsArray = new JsonArray();
                fieldsArray.add("summary");
                fieldsArray.add("status");
                fieldsArray.add("issuetype");
                fieldsArray.add("parent");
                requestJson.add("fields", fieldsArray);

                RequestBody body = RequestBody.create(
                        requestJson.toString(),
                        MediaType.parse("application/json")
                );

                Request request = new Request.Builder()
                        .url(url)
                        .header("Authorization", authHeader)
                        .header("Accept", "application/json")
                        .post(body)
                        .build();

                if (debugMode) {
                    logger.info("Searching issues: " + jql);
                }

                try (Response response = httpClient.newCall(request).execute()) {
                    if (!response.isSuccessful()) {
                        logger.warning("Failed to search issues: " + response.code());
                        return new ArrayList<>();
                    }

                    String responseBody = response.body().string();
                    JsonObject json = gson.fromJson(responseBody, JsonObject.class);
                    JsonArray issues = json.getAsJsonArray("issues");

                    List<JiraTicket> tickets = new ArrayList<>();
                    for (var element : issues) {
                        JsonObject issue = element.getAsJsonObject();
                        String key = issue.get("key").getAsString();
                        JsonObject fields = issue.getAsJsonObject("fields");
                        String summary = fields.get("summary").getAsString();
                        JsonObject status = fields.getAsJsonObject("status");
                        String statusName = status.get("name").getAsString();
                        String statusId = status.get("id").getAsString();

                        String issueType = null;
                        if (fields.has("issuetype") && !fields.get("issuetype").isJsonNull()) {
                            issueType = fields.getAsJsonObject("issuetype").get("name").getAsString();
                        }

                        String parentKey = null;
                        String parentSummary = null;
                        if (fields.has("parent") && !fields.get("parent").isJsonNull()) {
                            JsonObject parent = fields.getAsJsonObject("parent");
                            parentKey = parent.get("key").getAsString();
                            JsonObject parentFields = parent.getAsJsonObject("fields");
                            if (parentFields != null && parentFields.has("summary")) {
                                parentSummary = parentFields.get("summary").getAsString();
                            }
                        }

                        tickets.add(new JiraTicket(key, summary, statusName, statusId, parentKey, parentSummary, issueType));
                    }

                    if (debugMode) {
                        logger.info("Found " + tickets.size() + " issues");
                    }

                    return tickets;
                }
            } catch (IOException e) {
                logger.severe("Error searching issues: " + e.getMessage());
                return new ArrayList<>();
            }
        });
    }

    public void shutdown() {
        httpClient.dispatcher().executorService().shutdown();
        httpClient.connectionPool().evictAll();
    }
}
