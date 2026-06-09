package com.bynder.byndiecraft.listeners;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.board.BoardManager;
import com.bynder.byndiecraft.board.StatusColumn;
import com.bynder.byndiecraft.jira.JiraClient;
import com.bynder.byndiecraft.util.BookParser;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.Material;
import org.bukkit.entity.ItemFrame;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerInteractEntityEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.BookMeta;

import java.util.Optional;

public class ItemFrameListener implements Listener {
    private final ByndiecraftPlugin plugin;
    private final BoardManager boardManager;
    private final JiraClient jiraClient;
    private final boolean debugMode;

    public ItemFrameListener(ByndiecraftPlugin plugin, BoardManager boardManager, JiraClient jiraClient, boolean debugMode) {
        this.plugin = plugin;
        this.boardManager = boardManager;
        this.jiraClient = jiraClient;
        this.debugMode = debugMode;
    }

    @EventHandler(priority = EventPriority.MONITOR)
    public void onItemFrameInteract(PlayerInteractEntityEvent event) {
        if (!(event.getRightClicked() instanceof ItemFrame)) {
            if (debugMode) {
                plugin.getLogger().info("[DEBUG] Player interacted with non-frame entity");
            }
            return;
        }

        ItemFrame frame = (ItemFrame) event.getRightClicked();
        Player player = event.getPlayer();

        // Get location info
        int x = frame.getLocation().getBlockX();
        int y = frame.getLocation().getBlockY();
        int z = frame.getLocation().getBlockZ();
        String world = frame.getWorld().getName();

        // ALWAYS log frame interaction for debugging
        plugin.getLogger().info(String.format("[ItemFrame] ========================================"));
        plugin.getLogger().info(String.format("[ItemFrame] Player %s clicked frame!", player.getName()));
        plugin.getLogger().info(String.format("[ItemFrame] World: %s", world));
        plugin.getLogger().info(String.format("[ItemFrame] Coordinates: X=%d, Y=%d, Z=%d", x, y, z));
        plugin.getLogger().info(String.format("[ItemFrame] ========================================"));

        // Show in chat too
        player.sendMessage(Component.text(String.format("🔍 Clicked frame at: X=%d, Y=%d, Z=%d (World: %s)", x, y, z, world))
                .color(NamedTextColor.GRAY));

        // Check if this frame is part of our Jira board
        boolean isTracked = boardManager.isTrackedFrame(frame);
        plugin.getLogger().info("[ItemFrame] Frame is tracked: " + isTracked);
        player.sendMessage(Component.text("Frame tracked: " + isTracked)
                .color(isTracked ? NamedTextColor.GREEN : NamedTextColor.RED));

        if (!isTracked) {
            player.sendMessage(Component.text("⚠ This frame is not configured in the Jira board")
                    .color(NamedTextColor.YELLOW));
            player.sendMessage(Component.text("Run /jiraboard info to see configured frames")
                    .color(NamedTextColor.GRAY));
            return;
        }

        // Get the column this frame belongs to
        Optional<StatusColumn> columnOpt = boardManager.getColumnForFrame(frame);
        if (columnOpt.isEmpty()) {
            plugin.getLogger().warning("[ItemFrame] Frame is tracked but no column found! This shouldn't happen.");
            return;
        }

        StatusColumn column = columnOpt.get();
        plugin.getLogger().info("[ItemFrame] Frame belongs to column: " + column.getName());

        // Schedule the check slightly after the event to see what was placed
        Bukkit.getScheduler().runTaskLater(plugin, () -> {
            handleFrameUpdate(frame, column, player);
        }, 1L); // 1 tick delay to ensure the item is placed
    }

    private void handleFrameUpdate(ItemFrame frame, StatusColumn column, Player player) {
        ItemStack item = frame.getItem();

        plugin.getLogger().info("[ItemFrame] Checking frame content after 1 tick delay...");

        // Check if a book was placed in the frame
        if (item == null || item.getType() == Material.AIR) {
            plugin.getLogger().info("[ItemFrame] Frame is empty (no item or AIR)");
            return;
        }

        plugin.getLogger().info("[ItemFrame] Item in frame: " + item.getType());

        // Only handle written books
        if (item.getType() != Material.WRITTEN_BOOK) {
            plugin.getLogger().info("[ItemFrame] Item is not a WRITTEN_BOOK, ignoring");
            return;
        }

        BookMeta bookMeta = (BookMeta) item.getItemMeta();
        if (bookMeta == null || !bookMeta.hasTitle()) {
            plugin.getLogger().warning("[ItemFrame] Book has no title!");
            player.sendMessage(Component.text("⚠ Book must have a title with a Jira ticket key (e.g., TAP-123)")
                    .color(NamedTextColor.YELLOW));
            return;
        }

        String bookTitle = bookMeta.getTitle();
        plugin.getLogger().info("[ItemFrame] Book title: \"" + bookTitle + "\"");

        Optional<String> ticketKeyOpt = BookParser.extractTicketKey(bookTitle);

        if (ticketKeyOpt.isEmpty()) {
            plugin.getLogger().warning("[ItemFrame] No ticket key found in title: " + bookTitle);
            player.sendMessage(Component.text("⚠ No valid Jira ticket key found in book title: " + bookTitle)
                    .color(NamedTextColor.YELLOW));
            return;
        }

        String ticketKey = ticketKeyOpt.get();
        String targetStatus = column.getJiraStatusName();

        plugin.getLogger().info("[ItemFrame] Extracted ticket key: " + ticketKey);
        plugin.getLogger().info("[ItemFrame] Target Jira status: " + targetStatus);

        if (debugMode) {
            plugin.getLogger().info(String.format("Book placed: %s -> Column: %s (Jira: %s)",
                    ticketKey, column.getName(), targetStatus));
        }

        // Show loading message
        player.sendMessage(Component.text("⏳ Updating " + ticketKey + " to '" + targetStatus + "'...")
                .color(NamedTextColor.GRAY));

        // Update Jira asynchronously
        jiraClient.transitionIssue(ticketKey, targetStatus).thenAccept(success -> {
            // Schedule the response back on the main thread
            Bukkit.getScheduler().runTask(plugin, () -> {
                if (success) {
                    player.sendMessage(Component.text("✓ " + ticketKey + " moved to '" + targetStatus + "'")
                            .color(NamedTextColor.GREEN));
                    boardManager.cacheTicketStatus(ticketKey, targetStatus);

                    // Optional: Play success sound
                    player.playSound(player.getLocation(), org.bukkit.Sound.ENTITY_EXPERIENCE_ORB_PICKUP, 1.0f, 1.0f);
                } else {
                    player.sendMessage(Component.text("✗ Failed to update " + ticketKey + " in Jira")
                            .color(NamedTextColor.RED));
                    player.sendMessage(Component.text("Check if the ticket exists and you have permission to transition it.")
                            .color(NamedTextColor.GRAY));

                    // Optional: Play error sound
                    player.playSound(player.getLocation(), org.bukkit.Sound.ENTITY_VILLAGER_NO, 1.0f, 1.0f);
                }
            });
        }).exceptionally(throwable -> {
            Bukkit.getScheduler().runTask(plugin, () -> {
                player.sendMessage(Component.text("✗ Error: " + throwable.getMessage())
                        .color(NamedTextColor.RED));
                plugin.getLogger().severe("Exception during Jira transition: " + throwable.getMessage());
                throwable.printStackTrace();
            });
            return null;
        });
    }

    private String formatLocation(ItemFrame frame) {
        return String.format("(%d, %d, %d)",
                frame.getLocation().getBlockX(),
                frame.getLocation().getBlockY(),
                frame.getLocation().getBlockZ());
    }
}
