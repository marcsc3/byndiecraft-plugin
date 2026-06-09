package com.bynder.byndiecraft.board;

import org.bukkit.Location;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class StatusColumn {
    private final String name;
    private final String jiraStatusName;
    private final List<Location> frameLocations;

    public StatusColumn(String name, String jiraStatusName) {
        this.name = name;
        this.jiraStatusName = jiraStatusName;
        this.frameLocations = new ArrayList<>();
    }

    public String getName() {
        return name;
    }

    public String getJiraStatusName() {
        return jiraStatusName;
    }

    public List<Location> getFrameLocations() {
        return new ArrayList<>(frameLocations);
    }

    public void addFrameLocation(Location location) {
        frameLocations.add(location);
    }

    public void removeFrameLocation(Location location) {
        frameLocations.removeIf(loc ->
            loc.getWorld().equals(location.getWorld()) &&
            loc.getBlockX() == location.getBlockX() &&
            loc.getBlockY() == location.getBlockY() &&
            loc.getBlockZ() == location.getBlockZ()
        );
    }

    public boolean containsFrame(Location location) {
        return frameLocations.stream().anyMatch(loc ->
            loc.getWorld().equals(location.getWorld()) &&
            loc.getBlockX() == location.getBlockX() &&
            loc.getBlockY() == location.getBlockY() &&
            loc.getBlockZ() == location.getBlockZ()
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StatusColumn that = (StatusColumn) o;
        return Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

    @Override
    public String toString() {
        return String.format("%s (%s) - %d frames", name, jiraStatusName, frameLocations.size());
    }
}
