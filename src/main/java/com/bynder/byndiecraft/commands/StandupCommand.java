package com.bynder.byndiecraft.commands;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.board.BoardManager;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.Location;
import org.bukkit.Sound;
import org.bukkit.World;
import org.bukkit.command.Command;
import org.bukkit.command.CommandExecutor;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;
import org.jetbrains.annotations.NotNull;

import java.util.Collection;

public class StandupCommand implements CommandExecutor {
    private final ByndiecraftPlugin plugin;
    private final BoardManager boardManager;

    private static final int COLUMN_SPACING = 5;
    private static final int COLUMN_WIDTH = 2;
    private static final int VIEWING_DISTANCE = 4;

    public StandupCommand(ByndiecraftPlugin plugin, BoardManager boardManager) {
        this.plugin = plugin;
        this.boardManager = boardManager;
    }

    @Override
    public boolean onCommand(@NotNull CommandSender sender, @NotNull Command command, @NotNull String label, @NotNull String[] args) {
        Location anchor = getAnchorLocation();
        if (anchor == null) {
            sender.sendMessage(Component.text("No board anchor configured in config.yml!")
                    .color(NamedTextColor.RED));
            return true;
        }

        Collection<? extends Player> players = Bukkit.getOnlinePlayers();
        if (players.isEmpty()) {
            return true;
        }

        int playerCount = players.size();
        int i = 0;
        for (Player player : players) {
            double offsetX = -8 + i - (playerCount - 1) / 2.0;
            Location dest = new Location(anchor.getWorld(), offsetX, -60, 0, 180f, 0f);
            player.teleport(dest);
            player.playSound(dest, Sound.ENTITY_EXPERIENCE_ORB_PICKUP, 1.0f, 1.0f);
            i++;
        }

        Bukkit.broadcast(Component.text("Standup time! Gathering at the board...")
                .color(NamedTextColor.GOLD));

        return true;
    }

    private Location getAnchorLocation() {
        var config = plugin.getConfig();
        if (!config.contains("board.anchor")) {
            return null;
        }
        String worldName = config.getString("board.world", "world");
        World world = Bukkit.getWorld(worldName);
        if (world == null) return null;

        int x = config.getInt("board.anchor.x");
        int y = config.getInt("board.anchor.y");
        int z = config.getInt("board.anchor.z");
        return new Location(world, x, y, z);
    }
}
