package com.bynder.byndiecraft.board;

import com.bynder.byndiecraft.ByndiecraftPlugin;
import com.bynder.byndiecraft.jira.JiraClient;
import com.bynder.byndiecraft.jira.JiraTicket;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.*;
import org.bukkit.block.Block;
import org.bukkit.block.BlockFace;
import org.bukkit.block.Sign;
import org.bukkit.block.sign.Side;
import org.bukkit.entity.EntityType;
import org.bukkit.entity.ItemFrame;
import org.bukkit.entity.Player;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.BookMeta;

import java.util.*;
import java.util.stream.Collectors;

public class BoardSpawner {
    private final ByndiecraftPlugin plugin;
    private final JiraClient jiraClient;
    private final BoardManager boardManager;

    private static final int COLUMN_SPACING = 4;

    public BoardSpawner(ByndiecraftPlugin plugin, JiraClient jiraClient, BoardManager boardManager) {
        this.plugin = plugin;
        this.jiraClient = jiraClient;
        this.boardManager = boardManager;
    }

    public void spawn(Player player, Location anchor) {
        String projectKey = plugin.getConfigLoader().getProjectKey();

        player.sendMessage(Component.text("⏳ Fetching tickets from Jira project " + projectKey + "...")
                .color(NamedTextColor.GRAY));

        jiraClient.searchIssues(projectKey).thenAccept(tickets -> {
            Bukkit.getScheduler().runTask(plugin, () -> {
                if (tickets.isEmpty()) {
                    player.sendMessage(Component.text("⚠ No tickets found in project " + projectKey)
                            .color(NamedTextColor.YELLOW));
                    return;
                }

                player.sendMessage(Component.text("⏳ Building board with " + tickets.size() + " tickets...")
                        .color(NamedTextColor.GRAY));

                buildBoard(player, anchor, tickets);

                // Teleport all online players to the board
                Location tpTarget = anchor.clone().add(0, 0, 3);
                tpTarget.setYaw(0);
                tpTarget.setPitch(0);
                for (Player online : Bukkit.getOnlinePlayers()) {
                    online.teleport(tpTarget);
                    online.sendMessage(Component.text("✓ Teleported to the Jira board!")
                            .color(NamedTextColor.GREEN));
                }

                player.sendMessage(Component.text("✓ Board spawned with " + tickets.size() + " tickets!")
                        .color(NamedTextColor.GREEN));
                player.playSound(player.getLocation(), Sound.ENTITY_PLAYER_LEVELUP, 1.0f, 1.0f);
            });
        }).exceptionally(throwable -> {
            Bukkit.getScheduler().runTask(plugin, () -> {
                player.sendMessage(Component.text("✗ Error fetching tickets: " + throwable.getMessage())
                        .color(NamedTextColor.RED));
            });
            return null;
        });
    }

    public void clearBoard(Location anchor, int columnCount, int maxHeight) {
        World world = anchor.getWorld();
        if (world == null) return;

        int totalWidth = columnCount * COLUMN_SPACING;
        int startX = anchor.getBlockX();
        int startY = anchor.getBlockY();
        int startZ = anchor.getBlockZ();

        // Remove entities (item frames) in the area
        world.getEntities().stream()
                .filter(e -> e instanceof ItemFrame)
                .filter(e -> {
                    Location loc = e.getLocation();
                    return loc.getBlockX() >= startX && loc.getBlockX() < startX + totalWidth
                            && loc.getBlockY() >= startY - maxHeight && loc.getBlockY() <= startY + 1
                            && Math.abs(loc.getBlockZ() - startZ) <= 1;
                })
                .forEach(e -> e.remove());

        // Clear blocks (signs at startY+1, frames area, and backing wall)
        for (int x = startX; x < startX + totalWidth; x++) {
            for (int y = startY - maxHeight; y <= startY + 1; y++) {
                Block block = world.getBlockAt(x, y, startZ);
                if (block.getType() != Material.AIR) {
                    block.setType(Material.AIR);
                }
                Block backing = world.getBlockAt(x, y, startZ - 1);
                if (backing.getType() == Material.OAK_PLANKS) {
                    backing.setType(Material.AIR);
                }
            }
        }
    }

    private void buildBoard(Player player, Location anchor, List<JiraTicket> tickets) {
        World world = anchor.getWorld();
        if (world == null) return;

        // Group tickets by their current status (case-insensitive matching)
        Map<String, List<JiraTicket>> ticketsByStatus = tickets.stream()
                .collect(Collectors.groupingBy(t -> t.getStatus().toLowerCase()));

        if (plugin.getConfigLoader().isDebugMode()) {
            plugin.getLogger().info("Ticket statuses found: " + ticketsByStatus.keySet());
        }

        // Build columns dynamically: start with configured ones, then add any new statuses
        List<StatusColumn> columns = new ArrayList<>(boardManager.getBoard().getColumns());
        Set<String> knownStatuses = columns.stream()
                .map(c -> c.getJiraStatusName().toLowerCase())
                .collect(Collectors.toSet());

        for (String status : ticketsByStatus.keySet()) {
            if (!knownStatuses.contains(status)) {
                String displayName = tickets.stream()
                        .filter(t -> t.getStatus().toLowerCase().equals(status))
                        .map(JiraTicket::getStatus)
                        .findFirst()
                        .orElse(status);
                columns.add(new StatusColumn(displayName, displayName));
                if (plugin.getConfigLoader().isDebugMode()) {
                    plugin.getLogger().info("Auto-created column for status: " + displayName);
                }
            }
        }

        boardManager.getBoard().setColumns(columns);

        // Find tallest column to size the backing wall
        int maxHeight = ticketsByStatus.values().stream()
                .mapToInt(List::size)
                .max()
                .orElse(0);

        // Clear existing board
        clearBoard(anchor, columns.size(), maxHeight);

        int baseX = anchor.getBlockX();
        int baseY = anchor.getBlockY();
        int baseZ = anchor.getBlockZ();

        for (int colIdx = 0; colIdx < columns.size(); colIdx++) {
            StatusColumn column = columns.get(colIdx);
            int colX = baseX + (colIdx * COLUMN_SPACING);

            List<JiraTicket> columnTickets = ticketsByStatus.getOrDefault(column.getJiraStatusName().toLowerCase(), Collections.emptyList());
            int ticketCount = columnTickets.size();

            // Place backing wall for this column (includes sign row at baseY + 1)
            for (int y = baseY + 1; y >= baseY - ticketCount; y--) {
                for (int dx = 0; dx < 2; dx++) {
                    Block backing = world.getBlockAt(colX + dx, y, baseZ - 1);
                    backing.setType(Material.OAK_PLANKS);
                }
            }

            // Place sign header above column
            Block signBlock = world.getBlockAt(colX, baseY + 1, baseZ);
            signBlock.setType(Material.OAK_WALL_SIGN);
            org.bukkit.block.data.type.WallSign signData =
                    (org.bukkit.block.data.type.WallSign) signBlock.getBlockData();
            signData.setFacing(BlockFace.SOUTH);
            signBlock.setBlockData(signData);

            if (signBlock.getState() instanceof Sign sign) {
                sign.getSide(Side.FRONT).line(1, Component.text(column.getName()).color(NamedTextColor.DARK_BLUE));
                sign.update();
            }

            // Clear existing frame locations for this column
            column.getFrameLocations().forEach(column::removeFrameLocation);

            // Place item frames with books going downward from anchor
            for (int i = 0; i < ticketCount; i++) {
                JiraTicket ticket = columnTickets.get(i);
                int frameY = baseY - i;
                Location frameLoc = new Location(world, colX, frameY, baseZ);

                // Spawn item frame on the wall
                ItemFrame frame = (ItemFrame) world.spawnEntity(frameLoc, EntityType.ITEM_FRAME);
                frame.setFacingDirection(BlockFace.SOUTH);

                // Create a written book for this ticket
                ItemStack book = createTicketBook(ticket);
                frame.setItem(book);

                // Register this frame location with the board
                column.addFrameLocation(frameLoc);
                boardManager.cacheTicketStatus(ticket.getKey(), column.getJiraStatusName());
            }
        }
    }

    private ItemStack createTicketBook(JiraTicket ticket) {
        ItemStack book = new ItemStack(Material.WRITTEN_BOOK);
        BookMeta meta = (BookMeta) book.getItemMeta();

        meta.setTitle(ticket.getKey() + ": " + ticket.getSummary());
        meta.setAuthor("Jira");
        meta.itemName(Component.text(ticket.getKey() + ": " + ticket.getSummary()));
        meta.addPages(Component.text(ticket.getKey() + "\n\n" + ticket.getSummary() + "\n\nStatus: " + ticket.getStatus()));

        book.setItemMeta(meta);
        return book;
    }
}
