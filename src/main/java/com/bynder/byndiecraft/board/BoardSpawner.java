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
    private static final int BOARD_VERTICAL_GAP = 4;

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

                player.sendMessage(Component.text("⏳ Building boards grouped by parent (" + tickets.size() + " tickets)...")
                        .color(NamedTextColor.GRAY));

                buildBoardByParent(player, anchor, tickets);

                Location tpTarget = anchor.clone().add(0, 0, 3);
                tpTarget.setYaw(0);
                tpTarget.setPitch(0);
                for (Player online : Bukkit.getOnlinePlayers()) {
                    online.teleport(tpTarget);
                    online.sendMessage(Component.text("✓ Teleported to the Jira board!")
                            .color(NamedTextColor.GREEN));
                }

                player.sendMessage(Component.text("✓ Boards spawned with " + tickets.size() + " tickets!")
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

    public void spawnFlat(Player player, Location anchor) {
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

                player.sendMessage(Component.text("⏳ Building flat board with " + tickets.size() + " tickets...")
                        .color(NamedTextColor.GRAY));

                buildBoardFlat(player, anchor, tickets);

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

        world.getEntities().stream()
                .filter(e -> e instanceof ItemFrame)
                .filter(e -> {
                    Location loc = e.getLocation();
                    return loc.getBlockX() >= startX && loc.getBlockX() < startX + totalWidth
                            && loc.getBlockY() >= startY - maxHeight && loc.getBlockY() <= startY + 1
                            && Math.abs(loc.getBlockZ() - startZ) <= 1;
                })
                .forEach(e -> e.remove());

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

    public void clearLargeArea(Location anchor, int width, int height) {
        World world = anchor.getWorld();
        if (world == null) return;

        int startX = anchor.getBlockX();
        int startY = anchor.getBlockY();
        int startZ = anchor.getBlockZ();

        world.getEntities().stream()
                .filter(e -> e instanceof ItemFrame)
                .filter(e -> {
                    Location loc = e.getLocation();
                    return loc.getBlockX() >= startX && loc.getBlockX() < startX + width
                            && loc.getBlockY() >= startY - height && loc.getBlockY() <= startY + 2
                            && Math.abs(loc.getBlockZ() - startZ) <= 1;
                })
                .forEach(e -> e.remove());

        for (int x = startX; x < startX + width; x++) {
            for (int y = startY - height; y <= startY + 2; y++) {
                Block block = world.getBlockAt(x, y, startZ);
                if (block.getType() != Material.AIR) {
                    block.setType(Material.AIR);
                }
                Block backing = world.getBlockAt(x, y, startZ - 1);
                if (backing.getType() != Material.AIR) {
                    backing.setType(Material.AIR);
                }
            }
        }
    }

    private void buildBoardByParent(Player player, Location anchor, List<JiraTicket> tickets) {
        World world = anchor.getWorld();
        if (world == null) return;

        List<StatusColumn> columns = boardManager.getBoard().getColumns();

        // Group tickets by parent key (tickets without parent go under "No Parent")
        Map<String, List<JiraTicket>> ticketsByParent = new LinkedHashMap<>();
        Map<String, String> parentLabels = new LinkedHashMap<>();

        for (JiraTicket ticket : tickets) {
            String groupKey;
            if (ticket.hasParent()) {
                groupKey = ticket.getParentKey();
                parentLabels.putIfAbsent(groupKey, ticket.getParentKey() + ": " + ticket.getParentSummary());
            } else {
                groupKey = ticket.getKey();
                parentLabels.putIfAbsent(groupKey, ticket.getKey() + ": " + ticket.getSummary());
            }
            ticketsByParent.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(ticket);
        }

        if (plugin.getConfigLoader().isDebugMode()) {
            plugin.getLogger().info("Parent groups: " + ticketsByParent.keySet());
        }

        // Clear a large area
        int totalWidth = columns.size() * COLUMN_SPACING;
        int totalHeight = ticketsByParent.size() * (10 + BOARD_VERTICAL_GAP);
        clearLargeArea(anchor, totalWidth, totalHeight);

        int baseX = anchor.getBlockX();
        int currentY = anchor.getBlockY();
        int baseZ = anchor.getBlockZ();

        for (Map.Entry<String, List<JiraTicket>> entry : ticketsByParent.entrySet()) {
            String parentKey = entry.getKey();
            List<JiraTicket> parentTickets = entry.getValue();
            String label = parentLabels.get(parentKey);

            // Place parent title sign (2 blocks above the column headers)
            Block titleBlock = world.getBlockAt(baseX, currentY + 2, baseZ);
            titleBlock.setType(Material.OAK_WALL_SIGN);
            org.bukkit.block.data.type.WallSign titleSignData =
                    (org.bukkit.block.data.type.WallSign) titleBlock.getBlockData();
            titleSignData.setFacing(BlockFace.SOUTH);
            titleBlock.setBlockData(titleSignData);

            if (titleBlock.getState() instanceof Sign sign) {
                // Truncate label to fit sign
                String shortLabel = label.length() > 15 ? label.substring(0, 15) : label;
                sign.getSide(Side.FRONT).line(0, Component.text(parentKey).color(NamedTextColor.DARK_RED));
                sign.getSide(Side.FRONT).line(1, Component.text(shortLabel).color(NamedTextColor.BLACK));
                sign.update();
            }

            // Place backing for title
            Block titleBacking = world.getBlockAt(baseX, currentY + 2, baseZ - 1);
            titleBacking.setType(Material.OAK_PLANKS);

            // Group this parent's tickets by status
            Map<String, List<JiraTicket>> ticketsByStatus = parentTickets.stream()
                    .collect(Collectors.groupingBy(t -> t.getStatus().toLowerCase()));

            int maxTicketsInColumn = ticketsByStatus.values().stream()
                    .mapToInt(List::size)
                    .max()
                    .orElse(1);

            // Build columns for this parent's board
            for (int colIdx = 0; colIdx < columns.size(); colIdx++) {
                StatusColumn column = columns.get(colIdx);
                int colX = baseX + (colIdx * COLUMN_SPACING);

                List<JiraTicket> columnTickets = ticketsByStatus.getOrDefault(
                        column.getJiraStatusName().toLowerCase(), Collections.emptyList());
                int ticketCount = columnTickets.size();

                // Backing wall
                for (int y = currentY + 1; y >= currentY - ticketCount; y--) {
                    for (int dx = 0; dx < 2; dx++) {
                        Block backing = world.getBlockAt(colX + dx, y, baseZ - 1);
                        backing.setType(Material.OAK_PLANKS);
                    }
                }

                // Column header sign
                Block signBlock = world.getBlockAt(colX, currentY + 1, baseZ);
                signBlock.setType(Material.OAK_WALL_SIGN);
                org.bukkit.block.data.type.WallSign signData =
                        (org.bukkit.block.data.type.WallSign) signBlock.getBlockData();
                signData.setFacing(BlockFace.SOUTH);
                signBlock.setBlockData(signData);

                if (signBlock.getState() instanceof Sign sign) {
                    sign.getSide(Side.FRONT).line(1, Component.text(column.getName()).color(NamedTextColor.DARK_BLUE));
                    sign.update();
                }

                // Place item frames with books
                for (int i = 0; i < ticketCount; i++) {
                    JiraTicket ticket = columnTickets.get(i);
                    int frameY = currentY - i;
                    Location frameLoc = new Location(world, colX, frameY, baseZ);

                    ItemFrame frame = (ItemFrame) world.spawnEntity(frameLoc, EntityType.ITEM_FRAME);
                    frame.setFacingDirection(BlockFace.SOUTH);

                    ItemStack book = createTicketBook(ticket);
                    frame.setItem(book);

                    column.addFrameLocation(frameLoc);
                    boardManager.cacheTicketStatus(ticket.getKey(), column.getJiraStatusName());
                }
            }

            // Move down for next parent board
            currentY -= (maxTicketsInColumn + BOARD_VERTICAL_GAP);
        }
    }

    private void buildBoardFlat(Player player, Location anchor, List<JiraTicket> tickets) {
        World world = anchor.getWorld();
        if (world == null) return;

        Map<String, List<JiraTicket>> ticketsByStatus = tickets.stream()
                .collect(Collectors.groupingBy(t -> t.getStatus().toLowerCase()));

        if (plugin.getConfigLoader().isDebugMode()) {
            plugin.getLogger().info("Ticket statuses found: " + ticketsByStatus.keySet());
        }

        List<StatusColumn> columns = boardManager.getBoard().getColumns();

        int maxHeight = ticketsByStatus.values().stream()
                .mapToInt(List::size)
                .max()
                .orElse(0);

        clearBoard(anchor, columns.size(), maxHeight);

        int baseX = anchor.getBlockX();
        int baseY = anchor.getBlockY();
        int baseZ = anchor.getBlockZ();

        for (int colIdx = 0; colIdx < columns.size(); colIdx++) {
            StatusColumn column = columns.get(colIdx);
            int colX = baseX + (colIdx * COLUMN_SPACING);

            List<JiraTicket> columnTickets = ticketsByStatus.getOrDefault(column.getJiraStatusName().toLowerCase(), Collections.emptyList());
            int ticketCount = columnTickets.size();

            for (int y = baseY + 1; y >= baseY - ticketCount; y--) {
                for (int dx = 0; dx < 2; dx++) {
                    Block backing = world.getBlockAt(colX + dx, y, baseZ - 1);
                    backing.setType(Material.OAK_PLANKS);
                }
            }

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

            column.getFrameLocations().forEach(column::removeFrameLocation);

            for (int i = 0; i < ticketCount; i++) {
                JiraTicket ticket = columnTickets.get(i);
                int frameY = baseY - i;
                Location frameLoc = new Location(world, colX, frameY, baseZ);

                ItemFrame frame = (ItemFrame) world.spawnEntity(frameLoc, EntityType.ITEM_FRAME);
                frame.setFacingDirection(BlockFace.SOUTH);

                ItemStack book = createTicketBook(ticket);
                frame.setItem(book);

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
        meta.displayName(Component.text(ticket.getKey() + ": " + ticket.getSummary()).color(getColorForType(ticket.getIssueType())));
        meta.addPages(Component.text(ticket.getKey() + "\n\n" + ticket.getSummary() + "\n\nType: " + ticket.getIssueType() + "\nStatus: " + ticket.getStatus()));

        book.setItemMeta(meta);
        return book;
    }

    private NamedTextColor getColorForType(String issueType) {
        if (issueType == null) return NamedTextColor.WHITE;
        return switch (issueType.toLowerCase()) {
            case "bug" -> NamedTextColor.RED;
            case "story" -> NamedTextColor.GREEN;
            case "task", "sub-task", "subtask" -> NamedTextColor.BLUE;
            case "spike" -> NamedTextColor.GOLD;
            default -> NamedTextColor.WHITE;
        };
    }
}
