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
import org.bukkit.entity.Item;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.inventory.InventoryMoveItemEvent;
import org.bukkit.event.inventory.InventoryPickupItemEvent;
import org.bukkit.event.inventory.InventoryType;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.BookMeta;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AIChestListener implements Listener {
    private final ByndiecraftPlugin plugin;
    private final AITaskManager aiTaskManager;
    private Location aiHopperLocation;
    private ElevatorMusicPlayer elevatorMusic;

    public AIChestListener(ByndiecraftPlugin plugin, AITaskManager aiTaskManager) {
        this.plugin = plugin;
        this.aiTaskManager = aiTaskManager;
        loadAIHopperLocation();
    }

    private void loadAIHopperLocation() {
        if (plugin.getConfig().contains("ai.hopper_location")) {
            String worldName = plugin.getConfig().getString("ai.hopper_location.world");
            int x = plugin.getConfig().getInt("ai.hopper_location.x");
            int y = plugin.getConfig().getInt("ai.hopper_location.y");
            int z = plugin.getConfig().getInt("ai.hopper_location.z");

            org.bukkit.World world = Bukkit.getWorld(worldName);
            if (world != null && x != 0 && y != 0 && z != 0) {
                aiHopperLocation = new Location(world, x, y, z);
                plugin.getLogger().info(String.format("[AIHopper] AI Hopper configured at: %s (%d, %d, %d)",
                        worldName, x, y, z));
            } else {
                plugin.getLogger().warning("[AIHopper] AI Hopper location not properly configured");
            }
        }
    }

    public void setAIHopperLocation(Location location) {
        this.aiHopperLocation = location;
        plugin.getConfig().set("ai.hopper_location.world", location.getWorld().getName());
        plugin.getConfig().set("ai.hopper_location.x", location.getBlockX());
        plugin.getConfig().set("ai.hopper_location.y", location.getBlockY());
        plugin.getConfig().set("ai.hopper_location.z", location.getBlockZ());
        plugin.saveConfig();
        plugin.getLogger().info(String.format("[AIHopper] AI Hopper location updated: %s (%d, %d, %d)",
                location.getWorld().getName(), location.getBlockX(), location.getBlockY(), location.getBlockZ()));
    }

    public Location getAIHopperLocation() {
        return aiHopperLocation;
    }

    @EventHandler
    public void onHopperPickupItem(InventoryPickupItemEvent event) {
        if (!plugin.getConfig().getBoolean("ai.enabled", false)) {
            return;
        }

        if (aiHopperLocation == null) {
            return;
        }

        if (event.getInventory().getType() != InventoryType.HOPPER) {
            return;
        }

        Location hopperLoc = event.getInventory().getLocation();
        if (hopperLoc == null || !isAIHopper(hopperLoc)) {
            return;
        }

        Item droppedItem = event.getItem();
        ItemStack item = droppedItem.getItemStack();
        if (item.getType() != Material.WRITTEN_BOOK) {
            return;
        }

        plugin.getLogger().info("[AIHopper] Book picked up by AI hopper (dropped item)");

        event.setCancelled(true);
        droppedItem.remove();

        Bukkit.getScheduler().runTask(plugin, () -> {
            Player player = findNearbyPlayer(hopperLoc);
            if (player == null) {
                plugin.getLogger().warning("[AIHopper] No player found near hopper, cannot process book");
                return;
            }

            processBook(player, item.clone());
        });
    }

    @EventHandler
    public void onItemMoveToHopper(InventoryMoveItemEvent event) {
        if (!plugin.getConfig().getBoolean("ai.enabled", false)) {
            return;
        }

        if (aiHopperLocation == null) {
            return;
        }

        // Check if item is moving INTO a hopper
        if (event.getDestination().getType() != org.bukkit.event.inventory.InventoryType.HOPPER) {
            return;
        }

        // Check if this is our AI hopper
        Location hopperLoc = event.getDestination().getLocation();
        if (hopperLoc == null || !isAIHopper(hopperLoc)) {
            return;
        }

        ItemStack item = event.getItem();
        if (item == null || item.getType() != Material.WRITTEN_BOOK) {
            return;
        }

        plugin.getLogger().info(String.format("[AIHopper] Book detected entering AI hopper"));

        // Cancel the event - we'll consume the book
        event.setCancelled(true);

        // Process the book asynchronously
        Bukkit.getScheduler().runTask(plugin, () -> {
            // Try to find the player who dropped the item
            // For now, we'll use the first player near the hopper
            Player player = findNearbyPlayer(hopperLoc);
            if (player == null) {
                plugin.getLogger().warning("[AIHopper] No player found near hopper, cannot process book");
                return;
            }

            processBook(player, item.clone());
        });
    }

    private boolean isAIHopper(Location location) {
        if (aiHopperLocation == null) {
            return false;
        }

        return location.getWorld().equals(aiHopperLocation.getWorld()) &&
                location.getBlockX() == aiHopperLocation.getBlockX() &&
                location.getBlockY() == aiHopperLocation.getBlockY() &&
                location.getBlockZ() == aiHopperLocation.getBlockZ();
    }

    private Player findNearbyPlayer(Location location) {
        double searchRadius = 10.0;
        for (Player player : location.getWorld().getPlayers()) {
            if (player.getLocation().distance(location) <= searchRadius) {
                return player;
            }
        }
        return null;
    }

    private void processBook(Player player, ItemStack book) {
        // Extract ticket key from book title
        BookMeta bookMeta = (BookMeta) book.getItemMeta();
        if (bookMeta == null) {
            player.sendMessage(Component.text("⚠ Book must have a title with a Jira ticket key (e.g., SHARE-123)")
                    .color(NamedTextColor.YELLOW));
            return;
        }

        String bookTitle = bookMeta.getTitle();
        if (bookTitle == null || bookTitle.isEmpty()) {
            var displayName = bookMeta.displayName();
            if (displayName != null) {
                bookTitle = net.kyori.adventure.text.serializer.plain.PlainTextComponentSerializer.plainText().serialize(displayName);
            }
        }

        if (bookTitle == null || bookTitle.isEmpty()) {
            player.sendMessage(Component.text("⚠ Book must have a title with a Jira ticket key (e.g., SHARE-123)")
                    .color(NamedTextColor.YELLOW));
            return;
        }

        Optional<String> ticketKeyOpt = BookParser.extractTicketKey(bookTitle);

        if (ticketKeyOpt.isEmpty()) {
            player.sendMessage(Component.text("⚠ No valid Jira ticket key found in book title: " + bookTitle)
                    .color(NamedTextColor.YELLOW));
            return;
        }

        String ticketKey = ticketKeyOpt.get();

        // Visual and audio feedback
        if (plugin.getConfig().getBoolean("ai.visual_effects", true)) {
            player.playSound(player.getLocation(), Sound.BLOCK_ENCHANTMENT_TABLE_USE, 1.0f, 1.0f);

            // Spawn particles above hopper
            Location hopperLoc = aiHopperLocation.clone().add(0.5, 1, 0.5);
            player.spawnParticle(Particle.ENCHANT, hopperLoc, 50, 0.5, 0.5, 0.5, 0.1);
            player.spawnParticle(Particle.PORTAL, hopperLoc, 30, 0.3, 0.3, 0.3, 0.5);
        }

        Bukkit.broadcast(Component.text("🤖 Claude is implementing " + ticketKey + "...")
                .color(NamedTextColor.LIGHT_PURPLE));
        Bukkit.broadcast(Component.text("The hopper has consumed your book!")
                .color(NamedTextColor.GRAY));

        plugin.getLogger().info(String.format("[AIHopper] Starting AI task for ticket: %s", ticketKey));

        // Start elevator music while MCP is working
        if (plugin.getConfig().getBoolean("ai.elevator_music", true)) {
            elevatorMusic = new ElevatorMusicPlayer();
            elevatorMusic.start(plugin, aiHopperLocation.clone().add(0.5, 1, 0.5));
        }

        // Trigger AI task asynchronously
        aiTaskManager.implementTicket(player, ticketKey, book).thenAccept(result -> {
            // Schedule callback on main thread
            Bukkit.getScheduler().runTask(plugin, () -> {
                handleAIResult(player, book, result);
            });
        });
    }

    private void handleAIResult(Player player, ItemStack book, PRResult result) {
        if (elevatorMusic != null) {
            elevatorMusic.stop();
            elevatorMusic = null;
        }

        if (result.isSuccess()) {
            // Success - return book with PR link
            if (plugin.getConfig().getBoolean("ai.return_book_on_completion", true)) {
                returnBookWithPRLink(player, book, result.getPrUrl(), result.getSummary());
            }

            Bukkit.broadcast(Component.text("✅ PR Created: ")
                    .color(NamedTextColor.GREEN)
                    .append(Component.text(result.getPrUrl())
                            .color(NamedTextColor.AQUA)
                            .clickEvent(ClickEvent.openUrl(result.getPrUrl()))));

            if (plugin.getConfig().getBoolean("ai.visual_effects", true)) {
                player.playSound(player.getLocation(), Sound.ENTITY_PLAYER_LEVELUP, 1.0f, 1.0f);
                // Spawn success particles
                Location hopperLoc = aiHopperLocation.clone().add(0.5, 1, 0.5);
                player.spawnParticle(Particle.HAPPY_VILLAGER, hopperLoc, 20, 0.5, 0.5, 0.5, 0.1);
            }

            plugin.getLogger().info(String.format("[AIHopper] Success! PR: %s", result.getPrUrl()));
        } else {
            // Failure - return book with error
            returnBookWithError(player, book, result.getError());

            Bukkit.broadcast(Component.text("❌ Failed to implement ticket: " + result.getError())
                    .color(NamedTextColor.RED));

            if (plugin.getConfig().getBoolean("ai.visual_effects", true)) {
                player.playSound(player.getLocation(), Sound.ENTITY_VILLAGER_NO, 1.0f, 1.0f);
            }

            plugin.getLogger().warning(String.format("[AIHopper] Failed: %s", result.getError()));
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
