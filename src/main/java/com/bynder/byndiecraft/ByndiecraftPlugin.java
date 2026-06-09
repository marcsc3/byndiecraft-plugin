package com.bynder.byndiecraft;

import com.bynder.byndiecraft.board.BoardManager;
import com.bynder.byndiecraft.board.BoardSpawner;
import com.bynder.byndiecraft.board.JiraBoard;
import com.bynder.byndiecraft.commands.JiraBoardCommand;
import com.bynder.byndiecraft.jira.JiraClient;
import com.bynder.byndiecraft.listeners.ItemFrameListener;
import com.bynder.byndiecraft.util.ConfigLoader;
import org.bukkit.Bukkit;
import org.bukkit.command.PluginCommand;
import org.bukkit.plugin.java.JavaPlugin;

public class ByndiecraftPlugin extends JavaPlugin {
    private JiraClient jiraClient;
    private BoardManager boardManager;
    private ConfigLoader configLoader;

    @Override
    public void onEnable() {
        getLogger().info("=================================");
        getLogger().info("  Byndiecraft Plugin Starting");
        getLogger().info("  Minecraft ❤ Jira Integration");
        getLogger().info("=================================");

        // Save default config if it doesn't exist
        saveDefaultConfig();

        // Load configuration
        configLoader = new ConfigLoader(getConfig(), getLogger());

        // Validate Jira credentials
        String jiraUrl = configLoader.getJiraUrl();
        String jiraEmail = configLoader.getJiraEmail();
        String jiraApiToken = configLoader.getJiraApiToken();
        boolean debugMode = configLoader.isDebugMode();

        if (jiraEmail.isEmpty() || jiraEmail.equals("your-email@bynder.com")) {
            getLogger().warning("⚠ Jira email not configured! Please set 'jira.email' in config.yml");
        }

        if (jiraApiToken.isEmpty() || jiraApiToken.contains("${")) {
            getLogger().warning("⚠ Jira API token not configured!");
            getLogger().warning("Please either:");
            getLogger().warning("  1. Set JIRA_API_TOKEN environment variable, or");
            getLogger().warning("  2. Set 'jira.api_token' in config.yml");
            getLogger().warning("Generate a token at: https://id.atlassian.com/manage-profile/security/api-tokens");
        }

        // Initialize Jira client
        jiraClient = new JiraClient(jiraUrl, jiraEmail, jiraApiToken, getLogger(), debugMode);
        getLogger().info("✓ Jira client initialized: " + jiraUrl);

        // Load board configuration
        JiraBoard board = configLoader.loadBoard();
        boardManager = new BoardManager(board, getLogger());
        getLogger().info("✓ Board loaded: " + board.getColumns().size() + " columns");

        // Register event listeners
        ItemFrameListener itemFrameListener = new ItemFrameListener(this, boardManager, jiraClient, debugMode);
        Bukkit.getPluginManager().registerEvents(itemFrameListener, this);
        getLogger().info("✓ Event listeners registered");

        // Initialize board spawner
        BoardSpawner boardSpawner = new BoardSpawner(this, jiraClient, boardManager);

        // Register commands
        PluginCommand jiraBoardCommand = getCommand("jiraboard");
        if (jiraBoardCommand != null) {
            JiraBoardCommand commandExecutor = new JiraBoardCommand(this, boardManager, boardSpawner);
            jiraBoardCommand.setExecutor(commandExecutor);
            jiraBoardCommand.setTabCompleter(commandExecutor);
            getLogger().info("✓ Commands registered: /jiraboard");
        }

        // Print board status
        if (board.getColumns().isEmpty()) {
            getLogger().warning("⚠ No board columns configured!");
            getLogger().warning("Use /jiraboard setup to get started");
        } else {
            for (var column : board.getColumns()) {
                getLogger().info("  Column: " + column.getName() + " -> Jira: " + column.getJiraStatusName());
            }
        }

        getLogger().info("=================================");
        getLogger().info("  Byndiecraft Ready!");
        getLogger().info("  Place books in frames to update Jira");
        getLogger().info("=================================");
    }

    @Override
    public void onDisable() {
        getLogger().info("Shutting down Byndiecraft...");

        if (jiraClient != null) {
            jiraClient.shutdown();
            getLogger().info("✓ Jira client shutdown");
        }

        if (boardManager != null) {
            boardManager.clearCache();
            getLogger().info("✓ Board cache cleared");
        }

        getLogger().info("Byndiecraft disabled. Goodbye!");
    }

    public JiraClient getJiraClient() {
        return jiraClient;
    }

    public BoardManager getBoardManager() {
        return boardManager;
    }

    public ConfigLoader getConfigLoader() {
        return configLoader;
    }
}
