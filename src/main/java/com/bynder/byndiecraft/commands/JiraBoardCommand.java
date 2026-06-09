package com.bynder.byndiecraft.commands;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.board.BoardManager;
import com.bynder.byndiecraft.board.BoardSpawner;
import com.bynder.byndiecraft.board.StatusColumn;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Location;
import org.bukkit.command.Command;
import org.bukkit.command.CommandExecutor;
import org.bukkit.command.CommandSender;
import org.bukkit.command.TabCompleter;
import org.bukkit.entity.Player;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class JiraBoardCommand implements CommandExecutor, TabCompleter {
    private final ByndiecraftPlugin plugin;
    private final BoardManager boardManager;
    private final BoardSpawner boardSpawner;

    public JiraBoardCommand(ByndiecraftPlugin plugin, BoardManager boardManager, BoardSpawner boardSpawner) {
        this.plugin = plugin;
        this.boardManager = boardManager;
        this.boardSpawner = boardSpawner;
    }

    @Override
    public boolean onCommand(@NotNull CommandSender sender, @NotNull Command command, @NotNull String label, @NotNull String[] args) {
        if (args.length == 0) {
            sendHelp(sender);
            return true;
        }

        String subCommand = args[0].toLowerCase();

        switch (subCommand) {
            case "info":
                return handleInfo(sender);

            case "setup":
                return handleSetup(sender);

            case "addcolumn":
                if (args.length < 3) {
                    sender.sendMessage(Component.text("Usage: /jiraboard addcolumn <columnName> <jiraStatusName>")
                            .color(NamedTextColor.RED));
                    return true;
                }
                return handleAddColumn(sender, args[1], args[2]);

            case "spawn":
                return handleSpawn(sender);

            case "refresh":
                return handleRefresh(sender);

            case "help":
                sendHelp(sender);
                return true;

            default:
                sender.sendMessage(Component.text("Unknown subcommand: " + subCommand)
                        .color(NamedTextColor.RED));
                sendHelp(sender);
                return true;
        }
    }

    private boolean handleInfo(CommandSender sender) {
        String info = boardManager.getBoardInfo();
        sender.sendMessage(Component.text(info).color(NamedTextColor.AQUA));
        return true;
    }

    private boolean handleSetup(CommandSender sender) {
        sender.sendMessage(Component.text("=== Jira Board Setup ===").color(NamedTextColor.GOLD));
        sender.sendMessage(Component.text("1. Build your board with item frames in Minecraft").color(NamedTextColor.YELLOW));
        sender.sendMessage(Component.text("2. Organize frames into columns (one column per status)").color(NamedTextColor.YELLOW));
        sender.sendMessage(Component.text("3. Use /jiraboard addcolumn to register each column").color(NamedTextColor.YELLOW));
        sender.sendMessage(Component.text("4. Create written books with Jira ticket keys (e.g., 'TAP-123')").color(NamedTextColor.YELLOW));
        sender.sendMessage(Component.text("5. Place books in frames to trigger Jira updates!").color(NamedTextColor.YELLOW));
        sender.sendMessage(Component.text(""));
        sender.sendMessage(Component.text("Current board configuration:").color(NamedTextColor.GRAY));
        sender.sendMessage(Component.text(boardManager.getBoardInfo()).color(NamedTextColor.GRAY));
        return true;
    }

    private boolean handleAddColumn(CommandSender sender, String columnName, String jiraStatusName) {
        if (!(sender instanceof Player)) {
            sender.sendMessage(Component.text("This command can only be used by players!")
                    .color(NamedTextColor.RED));
            return true;
        }

        // Check if column already exists
        if (boardManager.getColumnByName(columnName).isPresent()) {
            sender.sendMessage(Component.text("Column '" + columnName + "' already exists!")
                    .color(NamedTextColor.RED));
            return true;
        }

        // Add the column
        StatusColumn newColumn = new StatusColumn(columnName, jiraStatusName);
        boardManager.getBoard().addColumn(newColumn);

        sender.sendMessage(Component.text("✓ Created column: " + columnName + " (Jira: " + jiraStatusName + ")")
                .color(NamedTextColor.GREEN));
        sender.sendMessage(Component.text("Now you can manually add frame coordinates to config.yml")
                .color(NamedTextColor.GRAY));
        sender.sendMessage(Component.text("or place item frames at specific coordinates and they'll be tracked automatically.")
                .color(NamedTextColor.GRAY));

        return true;
    }

    private boolean handleSpawn(CommandSender sender) {
        if (!(sender instanceof Player player)) {
            sender.sendMessage(Component.text("This command can only be used by players!")
                    .color(NamedTextColor.RED));
            return true;
        }

        Location anchor = getAnchorLocation(player);
        if (anchor == null) {
            player.sendMessage(Component.text("⚠ Board anchor not configured! Set board.anchor in config.yml")
                    .color(NamedTextColor.YELLOW));
            player.sendMessage(Component.text("Using your current location as anchor...")
                    .color(NamedTextColor.GRAY));
            anchor = player.getLocation().getBlock().getLocation();
        }

        boardSpawner.spawn(player, anchor);
        return true;
    }

    private boolean handleRefresh(CommandSender sender) {
        if (!(sender instanceof Player player)) {
            sender.sendMessage(Component.text("This command can only be used by players!")
                    .color(NamedTextColor.RED));
            return true;
        }

        Location anchor = getAnchorLocation(player);
        if (anchor == null) {
            anchor = player.getLocation().getBlock().getLocation();
        }

        boardSpawner.spawn(player, anchor);
        return true;
    }

    private Location getAnchorLocation(Player player) {
        var config = plugin.getConfig();
        if (config.contains("board.anchor")) {
            String worldName = config.getString("board.world", "world");
            var world = org.bukkit.Bukkit.getWorld(worldName);
            if (world == null) return null;

            int x = config.getInt("board.anchor.x");
            int y = config.getInt("board.anchor.y");
            int z = config.getInt("board.anchor.z");
            return new Location(world, x, y, z);
        }
        return null;
    }

    private void sendHelp(CommandSender sender) {
        sender.sendMessage(Component.text("=== Byndiecraft Commands ===").color(NamedTextColor.GOLD));
        sender.sendMessage(Component.text("/jiraboard info").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Show board configuration").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard setup").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Setup guide").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard addcolumn <name> <jiraStatus>").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Add a status column").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard spawn").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Spawn/create the Jira board in-world").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard refresh").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Rebuild board with fresh Jira data").color(NamedTextColor.GRAY)));
    }

    @Nullable
    @Override
    public List<String> onTabComplete(@NotNull CommandSender sender, @NotNull Command command, @NotNull String alias, @NotNull String[] args) {
        if (args.length == 1) {
            return Arrays.asList("info", "setup", "spawn", "addcolumn", "refresh", "help");
        }

        if (args.length == 2 && args[0].equalsIgnoreCase("addcolumn")) {
            return Arrays.asList("<columnName>");
        }

        if (args.length == 3 && args[0].equalsIgnoreCase("addcolumn")) {
            return Arrays.asList("To Do", "In Progress", "Done", "In Review", "Blocked");
        }

        return new ArrayList<>();
    }
}
