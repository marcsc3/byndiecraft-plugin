package com.bynder.byndiecraft.board;

import org.bukkit.Location;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class JiraBoard {
    private final String worldName;
    private final List<StatusColumn> columns;

    public JiraBoard(String worldName) {
        this.worldName = worldName;
        this.columns = new ArrayList<>();
    }

    public String getWorldName() {
        return worldName;
    }

    public List<StatusColumn> getColumns() {
        return new ArrayList<>(columns);
    }

    public void addColumn(StatusColumn column) {
        columns.add(column);
    }

    public void removeColumn(StatusColumn column) {
        columns.remove(column);
    }

    public Optional<StatusColumn> getColumnByName(String name) {
        return columns.stream()
                .filter(col -> col.getName().equalsIgnoreCase(name))
                .findFirst();
    }

    public Optional<StatusColumn> getColumnByJiraStatus(String jiraStatusName) {
        return columns.stream()
                .filter(col -> col.getJiraStatusName().equalsIgnoreCase(jiraStatusName))
                .findFirst();
    }

    public Optional<StatusColumn> getColumnByFrameLocation(Location location) {
        return columns.stream()
                .filter(col -> col.containsFrame(location))
                .findFirst();
    }

    public boolean hasFrameAt(Location location) {
        return getColumnByFrameLocation(location).isPresent();
    }

    @Override
    public String toString() {
        return String.format("JiraBoard[%s] - %d columns", worldName, columns.size());
    }
}
