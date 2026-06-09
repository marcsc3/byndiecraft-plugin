package com.bynder.byndiecraft.commands;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.board.BoardManager;
import com.bynder.byndiecraft.board.BoardSpawner;
import com.bynder.byndiecraft.board.StatusColumn;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Location;
import org.bukkit.block.Block;
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

            case "debug":
                return handleDebug(sender);

            case "spawn":
                return handleSpawn(sender);

            case "refresh":
                return handleRefresh(sender);

            case "setaichest":
                return handleSetAIChest(sender);

            case "aiinfo":
                return handleAIInfo(sender);

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

    private boolean handleDebug(CommandSender sender) {
        sender.sendMessage(Component.text("=== Byndiecraft Debug Info ===").color(NamedTextColor.GOLD));

        // Show listener status
        sender.sendMessage(Component.text("✓ Event listeners: REGISTERED").color(NamedTextColor.GREEN));

        // Show board configuration
        String boardInfo = boardManager.getBoardInfo();
        sender.sendMessage(Component.text(boardInfo).color(NamedTextColor.AQUA));

        // Show player location if player
        if (sender instanceof Player) {
            Player player = (Player) sender;
            sender.sendMessage(Component.text("Your location:").color(NamedTextColor.YELLOW));
            sender.sendMessage(Component.text(String.format("  World: %s", player.getWorld().getName()))
                    .color(NamedTextColor.GRAY));
            sender.sendMessage(Component.text(String.format("  X: %d, Y: %d, Z: %d",
                    player.getLocation().getBlockX(),
                    player.getLocation().getBlockY(),
                    player.getLocation().getBlockZ()))
                    .color(NamedTextColor.GRAY));
        }

        sender.sendMessage(Component.text("Check console logs for detailed event tracking")
                .color(NamedTextColor.YELLOW));

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

    private boolean handleSetAIChest(CommandSender sender) {
        if (!(sender instanceof Player player)) {
            sender.sendMessage(Component.text("This command can only be used by players!")
                    .color(NamedTextColor.RED));
            return true;
        }

        if (!plugin.getConfig().getBoolean("ai.enabled", false)) {
            player.sendMessage(Component.text("⚠ AI system is disabled. Set ai.enabled: true in config.yml")
                    .color(NamedTextColor.YELLOW));
            return true;
        }

        // Get the block the player is looking at
        Block targetBlock = player.getTargetBlockExact(5);
        if (targetBlock == null || targetBlock.getType() != org.bukkit.Material.CHEST) {
            player.sendMessage(Component.text("⚠ You must be looking at a chest!")
                    .color(NamedTextColor.YELLOW));
            player.sendMessage(Component.text("Look at a chest and run this command again")
                    .color(NamedTextColor.GRAY));
            return true;
        }

        Location chestLocation = targetBlock.getLocation();
        var aiChestListener = plugin.getAIChestListener();
        if (aiChestListener != null) {
            aiChestListener.setAIChestLocation(chestLocation);
            player.sendMessage(Component.text("✓ AI Chest set at: " +
                    String.format("(%d, %d, %d)", chestLocation.getBlockX(), chestLocation.getBlockY(), chestLocation.getBlockZ()))
                    .color(NamedTextColor.GREEN));
            player.sendMessage(Component.text("Place written books with Jira ticket keys in this chest to trigger AI implementation!")
                    .color(NamedTextColor.GRAY));
        } else {
            player.sendMessage(Component.text("⚠ AI system not initialized")
                    .color(NamedTextColor.RED));
        }

        return true;
    }

    private boolean handleAIInfo(CommandSender sender) {
        sender.sendMessage(Component.text("=== AI System Info ===").color(NamedTextColor.GOLD));

        boolean aiEnabled = plugin.getConfig().getBoolean("ai.enabled", false);
        sender.sendMessage(Component.text("Status: " + (aiEnabled ? "ENABLED" : "DISABLED"))
                .color(aiEnabled ? NamedTextColor.GREEN : NamedTextColor.RED));

        if (!aiEnabled) {
            sender.sendMessage(Component.text("Set ai.enabled: true in config.yml to enable Phase 2")
                    .color(NamedTextColor.GRAY));
            return true;
        }

        String mcpEndpoint = plugin.getConfig().getString("ai.mcp_endpoint");
        sender.sendMessage(Component.text("MCP Endpoint: " + mcpEndpoint).color(NamedTextColor.AQUA));

        String modelId = plugin.getConfig().getString("ai.bedrock.model_id");
        sender.sendMessage(Component.text("Bedrock Model: " + modelId).color(NamedTextColor.AQUA));

        var aiChestListener = plugin.getAIChestListener();
        if (aiChestListener != null) {
            Location aiChestLoc = aiChestListener.getAIChestLocation();
            if (aiChestLoc != null) {
                sender.sendMessage(Component.text(String.format("AI Chest: %s (%d, %d, %d)",
                        aiChestLoc.getWorld().getName(),
                        aiChestLoc.getBlockX(),
                        aiChestLoc.getBlockY(),
                        aiChestLoc.getBlockZ()))
                        .color(NamedTextColor.GREEN));
            } else {
                sender.sendMessage(Component.text("AI Chest: Not configured")
                        .color(NamedTextColor.YELLOW));
                sender.sendMessage(Component.text("Use /jiraboard setaichest to configure")
                        .color(NamedTextColor.GRAY));
            }
        }

        return true;
    }

    private void sendHelp(CommandSender sender) {
        sender.sendMessage(Component.text("=== Byndiecraft Commands ===").color(NamedTextColor.GOLD));
        sender.sendMessage(Component.text("/jiraboard info").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Show board configuration").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard debug").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Show debug information").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard setup").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Setup guide").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard addcolumn <name> <jiraStatus>").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Add a status column").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard spawn").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Spawn/create the Jira board in-world").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard refresh").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Rebuild board with fresh Jira data").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text(""));
        sender.sendMessage(Component.text("=== AI Commands (Phase 2) ===").color(NamedTextColor.LIGHT_PURPLE));
        sender.sendMessage(Component.text("/jiraboard setaichest").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Set AI chest (look at chest)").color(NamedTextColor.GRAY)));
        sender.sendMessage(Component.text("/jiraboard aiinfo").color(NamedTextColor.YELLOW)
                .append(Component.text(" - Show AI system status").color(NamedTextColor.GRAY)));
    }

    @Nullable
    @Override
    public List<String> onTabComplete(@NotNull CommandSender sender, @NotNull Command command, @NotNull String alias, @NotNull String[] args) {
        if (args.length == 1) {
            return Arrays.asList("info", "setup", "spawn", "addcolumn", "refresh", "setaichest", "aiinfo", "debug", "help");
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
