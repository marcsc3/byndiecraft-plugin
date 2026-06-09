package com.bynder.byndiecraft.util;

import com.bynder.byndiecraft.board.JiraBoard;
import com.bynder.byndiecraft.board.StatusColumn;
import org.bukkit.Bukkit;
import org.bukkit.Location;
import org.bukkit.World;
import org.bukkit.configuration.ConfigurationSection;
import org.bukkit.configuration.file.FileConfiguration;
import org.bukkit.configuration.file.YamlConfiguration;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class ConfigLoader {
    private final FileConfiguration config;
    private final FileConfiguration credentials;
    private final Logger logger;

    public ConfigLoader(FileConfiguration config, File dataFolder, Logger logger) {
        this.config = config;
        this.logger = logger;
        this.credentials = loadCredentials(dataFolder);
    }

    private FileConfiguration loadCredentials(File dataFolder) {
        File credFile = new File(dataFolder, "credentials.yml");
        if (credFile.exists()) {
            logger.info("Loading credentials from credentials.yml");
            return YamlConfiguration.loadConfiguration(credFile);
        }
        logger.warning("credentials.yml not found in " + dataFolder.getPath());
        return new YamlConfiguration();
    }

    public String getJiraUrl() {
        return config.getString("jira.url", "https://bynder.atlassian.net");
    }

    public String getJiraEmail() {
        String email = credentials.getString("jira.email", "");
        if (email.isEmpty()) {
            email = config.getString("jira.email", "");
        }
        return email;
    }

    public String getJiraApiToken() {
        // Priority: credentials.yml > env var > config.yml
        String token = credentials.getString("jira.api_token", "");
        if (!token.isEmpty()) {
            return token;
        }

        token = config.getString("jira.api_token", "");
        if (token.startsWith("${") && token.endsWith("}")) {
            String envVar = token.substring(2, token.length() - 1);
            String envValue = System.getenv(envVar);
            if (envValue != null && !envValue.isEmpty()) {
                return envValue;
            }
            logger.warning("Environment variable " + envVar + " not set!");
        }
        return token;
    }

    public String getProjectKey() {
        return config.getString("jira.project_key", "TAP");
    }

    public boolean isDebugMode() {
        return config.getBoolean("debug", false);
    }

    public JiraBoard loadBoard() {
        String worldName = config.getString("board.world", "world");
        JiraBoard board = new JiraBoard(worldName);

        List<Map<?, ?>> columns = config.getMapList("board.columns");
        for (Map<?, ?> columnData : columns) {
            String name = (String) columnData.get("name");
            String jiraStatusName = (String) columnData.get("jira_status_name");

            if (name == null || jiraStatusName == null) {
                logger.warning("Skipping invalid column configuration");
                continue;
            }

            StatusColumn column = new StatusColumn(name, jiraStatusName);

            @SuppressWarnings("unchecked")
            List<Map<?, ?>> frames = (List<Map<?, ?>>) columnData.get("frames");
            if (frames != null) {
                World world = Bukkit.getWorld(worldName);
                if (world == null) {
                    logger.warning("World " + worldName + " not found!");
                    continue;
                }

                for (Map<?, ?> frameData : frames) {
                    try {
                        int x = ((Number) frameData.get("x")).intValue();
                        int y = ((Number) frameData.get("y")).intValue();
                        int z = ((Number) frameData.get("z")).intValue();
                        Location location = new Location(world, x, y, z);
                        column.addFrameLocation(location);
                    } catch (Exception e) {
                        logger.warning("Invalid frame coordinates: " + e.getMessage());
                    }
                }
            }

            board.addColumn(column);
        }

        logger.info("Loaded board with " + board.getColumns().size() + " columns");
        return board;
    }

    public void saveBoard(JiraBoard board) {
        // TODO: Implement saving board configuration back to config.yml
        // This would be needed for the /jiraboard setup command
        logger.info("Board saving not yet implemented");
    }
}
