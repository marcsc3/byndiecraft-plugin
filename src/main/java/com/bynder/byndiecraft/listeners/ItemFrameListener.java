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
            return;
        }

        ItemFrame frame = (ItemFrame) event.getRightClicked();
        Player player = event.getPlayer();

        // Check if this frame is part of our Jira board
        if (!boardManager.isTrackedFrame(frame)) {
            return;
        }

        // Get the column this frame belongs to
        Optional<StatusColumn> columnOpt = boardManager.getColumnForFrame(frame);
        if (columnOpt.isEmpty()) {
            return;
        }

        StatusColumn column = columnOpt.get();

        // Schedule the check slightly after the event to see what was placed
        Bukkit.getScheduler().runTaskLater(plugin, () -> {
            handleFrameUpdate(frame, column, player);
        }, 1L); // 1 tick delay to ensure the item is placed
    }

    private void handleFrameUpdate(ItemFrame frame, StatusColumn column, Player player) {
        ItemStack item = frame.getItem();

        // Check if a book was placed in the frame
        if (item == null || item.getType() == Material.AIR) {
            if (debugMode) {
                plugin.getLogger().info("Frame emptied at " + formatLocation(frame));
            }
            return;
        }

        // Only handle written books
        if (item.getType() != Material.WRITTEN_BOOK) {
            return;
        }

        BookMeta bookMeta = (BookMeta) item.getItemMeta();
        if (bookMeta == null || !bookMeta.hasTitle()) {
            player.sendMessage(Component.text("⚠ Book must have a title with a Jira ticket key (e.g., TAP-123)")
                    .color(NamedTextColor.YELLOW));
            return;
        }

        String bookTitle = bookMeta.getTitle();
        Optional<String> ticketKeyOpt = BookParser.extractTicketKey(bookTitle);

        if (ticketKeyOpt.isEmpty()) {
            player.sendMessage(Component.text("⚠ No valid Jira ticket key found in book title: " + bookTitle)
                    .color(NamedTextColor.YELLOW));
            return;
        }

        String ticketKey = ticketKeyOpt.get();
        String targetStatus = column.getJiraStatusName();

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
