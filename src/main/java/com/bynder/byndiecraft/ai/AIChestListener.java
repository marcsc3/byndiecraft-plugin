package com.bynder.byndiecraft.ai;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.ai.models.PRResult;
import com.bynder.byndiecraft.util.BookParser;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.event.ClickEvent;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.Location;
import org.bukkit.Material;
import org.bukkit.Particle;
import org.bukkit.Sound;
import org.bukkit.block.Block;
import org.bukkit.block.Chest;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.inventory.InventoryClickEvent;
import org.bukkit.event.inventory.InventoryType;
import org.bukkit.inventory.Inventory;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.BookMeta;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AIChestListener implements Listener {
    private final ByndiecraftPlugin plugin;
    private final AITaskManager aiTaskManager;
    private Location aiChestLocation;

    public AIChestListener(ByndiecraftPlugin plugin, AITaskManager aiTaskManager) {
        this.plugin = plugin;
        this.aiTaskManager = aiTaskManager;
        loadAIChestLocation();
    }

    private void loadAIChestLocation() {
        if (plugin.getConfig().contains("ai.chest_location")) {
            String worldName = plugin.getConfig().getString("ai.chest_location.world");
            int x = plugin.getConfig().getInt("ai.chest_location.x");
            int y = plugin.getConfig().getInt("ai.chest_location.y");
            int z = plugin.getConfig().getInt("ai.chest_location.z");

            org.bukkit.World world = Bukkit.getWorld(worldName);
            if (world != null && x != 0 && y != 0 && z != 0) {
                aiChestLocation = new Location(world, x, y, z);
                plugin.getLogger().info(String.format("[AIChest] AI Chest configured at: %s (%d, %d, %d)",
                        worldName, x, y, z));
            } else {
                plugin.getLogger().warning("[AIChest] AI Chest location not properly configured");
            }
        }
    }

    public void setAIChestLocation(Location location) {
        this.aiChestLocation = location;
        plugin.getConfig().set("ai.chest_location.world", location.getWorld().getName());
        plugin.getConfig().set("ai.chest_location.x", location.getBlockX());
        plugin.getConfig().set("ai.chest_location.y", location.getBlockY());
        plugin.getConfig().set("ai.chest_location.z", location.getBlockZ());
        plugin.saveConfig();
        plugin.getLogger().info(String.format("[AIChest] AI Chest location updated: %s (%d, %d, %d)",
                location.getWorld().getName(), location.getBlockX(), location.getBlockY(), location.getBlockZ()));
    }

    public Location getAIChestLocation() {
        return aiChestLocation;
    }

    @EventHandler
    public void onInventoryClick(InventoryClickEvent event) {
        if (!plugin.getConfig().getBoolean("ai.enabled", false)) {
            return;
        }

        if (aiChestLocation == null) {
            return;
        }

        if (!(event.getWhoClicked() instanceof Player)) {
            return;
        }

        Player player = (Player) event.getWhoClicked();
        Inventory inventory = event.getInventory();

        // Check if this is a chest inventory
        if (inventory.getType() != InventoryType.CHEST) {
            return;
        }

        // Check if the chest is at the AI chest location
        Location invLocation = inventory.getLocation();
        if (invLocation == null || !isAIChest(invLocation)) {
            return;
        }

        // Check if the player is placing a book into the chest
        ItemStack currentItem = event.getCurrentItem();
        ItemStack cursorItem = event.getCursor();

        ItemStack bookToProcess = null;

        // Detect if placing book from cursor into chest
        if (cursorItem != null && cursorItem.getType() == Material.WRITTEN_BOOK) {
            bookToProcess = cursorItem.clone();
        }
        // Detect if shift-clicking book into chest
        else if (currentItem != null && currentItem.getType() == Material.WRITTEN_BOOK &&
                event.isShiftClick() && event.getClickedInventory() != inventory) {
            bookToProcess = currentItem.clone();
        }

        if (bookToProcess != null) {
            plugin.getLogger().info(String.format("[AIChest] Player %s placed book in AI chest", player.getName()));

            // Process the book
            processBook(player, bookToProcess, event);
        }
    }

    private boolean isAIChest(Location location) {
        if (aiChestLocation == null) {
            return false;
        }

        return location.getWorld().equals(aiChestLocation.getWorld()) &&
                location.getBlockX() == aiChestLocation.getBlockX() &&
                location.getBlockY() == aiChestLocation.getBlockY() &&
                location.getBlockZ() == aiChestLocation.getBlockZ();
    }

    private void processBook(Player player, ItemStack book, InventoryClickEvent event) {
        // Extract ticket key from book title
        BookMeta bookMeta = (BookMeta) book.getItemMeta();
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

        // Remove the book from cursor/inventory
        event.setCancelled(true);
        Bukkit.getScheduler().runTask(plugin, () -> {
            if (event.getCursor() != null && event.getCursor().getType() == Material.WRITTEN_BOOK) {
                event.getCursor().setAmount(0);
            } else if (event.getCurrentItem() != null) {
                event.getCurrentItem().setAmount(0);
            }
        });

        // Visual and audio feedback
        if (plugin.getConfig().getBoolean("ai.visual_effects", true)) {
            player.playSound(player.getLocation(), Sound.BLOCK_ENCHANTMENT_TABLE_USE, 1.0f, 1.0f);

            // Spawn particles above chest
            Location chestLoc = aiChestLocation.clone().add(0.5, 1, 0.5);
            player.spawnParticle(Particle.ENCHANT, chestLoc, 50, 0.5, 0.5, 0.5, 0.1);
        }

        player.sendMessage(Component.text("🤖 Claude is implementing " + ticketKey + "...")
                .color(NamedTextColor.LIGHT_PURPLE));

        plugin.getLogger().info(String.format("[AIChest] Starting AI task for ticket: %s", ticketKey));

        // Trigger AI task asynchronously
        aiTaskManager.implementTicket(player, ticketKey, book).thenAccept(result -> {
            // Schedule callback on main thread
            Bukkit.getScheduler().runTask(plugin, () -> {
                handleAIResult(player, book, result);
            });
        });
    }

    private void handleAIResult(Player player, ItemStack book, PRResult result) {
        if (result.isSuccess()) {
            // Success - return book with PR link
            if (plugin.getConfig().getBoolean("ai.return_book_on_completion", true)) {
                returnBookWithPRLink(player, book, result.getPrUrl(), result.getSummary());
            }

            player.sendMessage(Component.text("✅ PR Created: ")
                    .color(NamedTextColor.GREEN)
                    .append(Component.text(result.getPrUrl())
                            .color(NamedTextColor.AQUA)
                            .clickEvent(ClickEvent.openUrl(result.getPrUrl()))));

            if (plugin.getConfig().getBoolean("ai.visual_effects", true)) {
                player.playSound(player.getLocation(), Sound.ENTITY_PLAYER_LEVELUP, 1.0f, 1.0f);
            }

            plugin.getLogger().info(String.format("[AIChest] Success! PR: %s", result.getPrUrl()));
        } else {
            // Failure - return book with error
            returnBookWithError(player, book, result.getError());

            player.sendMessage(Component.text("❌ Failed to implement ticket: " + result.getError())
                    .color(NamedTextColor.RED));

            if (plugin.getConfig().getBoolean("ai.visual_effects", true)) {
                player.playSound(player.getLocation(), Sound.ENTITY_VILLAGER_NO, 1.0f, 1.0f);
            }

            plugin.getLogger().warning(String.format("[AIChest] Failed: %s", result.getError()));
        }
    }

    private void returnBookWithPRLink(Player player, ItemStack book, String prUrl, String summary) {
        BookMeta meta = (BookMeta) book.getItemMeta();

        // Add PR link to book lore
        if (plugin.getConfig().getBoolean("ai.add_pr_link_to_book_lore", true)) {
            List<String> lore = new ArrayList<>();
            lore.add("§bPR Created:");
            lore.add("§f" + prUrl);
            if (summary != null && !summary.isEmpty()) {
                lore.add("");
                lore.add("§7" + summary);
            }
            meta.setLore(lore);
        }

        book.setItemMeta(meta);
        player.getInventory().addItem(book);

        player.sendMessage(Component.text("📖 Book returned with PR link!")
                .color(NamedTextColor.GRAY));
    }

    private void returnBookWithError(Player player, ItemStack book, String error) {
        BookMeta meta = (BookMeta) book.getItemMeta();

        List<String> lore = new ArrayList<>();
        lore.add("§cImplementation Failed:");
        lore.add("§7" + error);
        meta.setLore(lore);

        book.setItemMeta(meta);
        player.getInventory().addItem(book);

        player.sendMessage(Component.text("📖 Book returned with error details")
                .color(NamedTextColor.GRAY));
    }
}
