package com.bynder.byndiecraft.board;

import org.bukkit.Location;
import org.bukkit.entity.ItemFrame;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.logging.Logger;

public class BoardManager {
    private final JiraBoard board;
    private final Logger logger;
    private final Map<String, String> ticketStatusCache; // ticketKey -> current status

    public BoardManager(JiraBoard board, Logger logger) {
        this.board = board;
        this.logger = logger;
        this.ticketStatusCache = new HashMap<>();
    }

    public JiraBoard getBoard() {
        return board;
    }

    public Optional<StatusColumn> getColumnForFrame(ItemFrame frame) {
        Location location = frame.getLocation();
        return board.getColumnByFrameLocation(location);
    }

    public Optional<StatusColumn> getColumnByName(String name) {
        return board.getColumnByName(name);
    }

    public Optional<StatusColumn> getColumnByJiraStatus(String jiraStatusName) {
        return board.getColumnByJiraStatus(jiraStatusName);
    }

    public boolean isTrackedFrame(ItemFrame frame) {
        return board.hasFrameAt(frame.getLocation());
    }

    public void cacheTicketStatus(String ticketKey, String status) {
        ticketStatusCache.put(ticketKey, status);
    }

    public Optional<String> getCachedStatus(String ticketKey) {
        return Optional.ofNullable(ticketStatusCache.get(ticketKey));
    }

    public void clearCache() {
        ticketStatusCache.clear();
    }

    public String getBoardInfo() {
        StringBuilder info = new StringBuilder();
        info.append("=== Byndiecraft Jira Board ===\n");
        info.append("World: ").append(board.getWorldName()).append("\n");
        info.append("Columns: ").append(board.getColumns().size()).append("\n\n");

        for (StatusColumn column : board.getColumns()) {
            info.append("- ").append(column.getName())
                .append(" (Jira: ").append(column.getJiraStatusName()).append(")\n");
            info.append("  Frames: ").append(column.getFrameLocations().size()).append("\n");

            for (Location loc : column.getFrameLocations()) {
                info.append("    • (").append(loc.getBlockX()).append(", ")
                    .append(loc.getBlockY()).append(", ")
                    .append(loc.getBlockZ()).append(")\n");
            }
        }

        return info.toString();
    }

    public void addFrameToColumn(String columnName, Location location) {
        Optional<StatusColumn> column = board.getColumnByName(columnName);
        if (column.isPresent()) {
            column.get().addFrameLocation(location);
            logger.info("Added frame at " + formatLocation(location) + " to column: " + columnName);
        } else {
            logger.warning("Column not found: " + columnName);
        }
    }

    public void removeFrameFromColumn(Location location) {
        Optional<StatusColumn> column = board.getColumnByFrameLocation(location);
        if (column.isPresent()) {
            column.get().removeFrameLocation(location);
            logger.info("Removed frame at " + formatLocation(location) + " from column: " + column.get().getName());
        }
    }

    private String formatLocation(Location loc) {
        return String.format("(%d, %d, %d)", loc.getBlockX(), loc.getBlockY(), loc.getBlockZ());
    }
}
