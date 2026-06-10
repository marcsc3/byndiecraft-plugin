package com.bynder.byndiecraft.ai;

import org.bukkit.Bukkit;
import org.bukkit.Location;
import org.bukkit.Sound;
import org.bukkit.entity.Player;
import org.bukkit.plugin.Plugin;

public class ElevatorMusicPlayer {

    public void start(Plugin plugin, Location location) {
        for (Player player : Bukkit.getOnlinePlayers()) {
            player.playSound(player.getLocation(), Sound.MUSIC_DISC_CAT, 1.0f, 1.0f);
        }
    }

    public void stop() {
        for (Player player : Bukkit.getOnlinePlayers()) {
            player.stopSound(Sound.MUSIC_DISC_CAT);
        }
    }
}
