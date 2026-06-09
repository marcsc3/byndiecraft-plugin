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

    private static final int COLUMN_WIDTH = 2;
    private static final int COLUMN_SPACING = 5;

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


    private void buildBoard(Player player, Location anchor, List<JiraTicket> tickets) {
        World world = anchor.getWorld();
        if (world == null) return;

        Map<String, List<JiraTicket>> ticketsByStatus = tickets.stream()
                .collect(Collectors.groupingBy(t -> t.getStatus().toLowerCase()));

        if (plugin.getConfigLoader().isDebugMode()) {
            plugin.getLogger().info("Ticket statuses found: " + ticketsByStatus.keySet());
        }

        List<StatusColumn> columns = boardManager.getBoard().getColumns();

        // With 2-wide columns, height is ceil(ticketCount / 2)
        int maxRows = ticketsByStatus.values().stream()
                .mapToInt(list -> (list.size() + COLUMN_WIDTH - 1) / COLUMN_WIDTH)
                .max()
                .orElse(0);

        clearBoard(anchor, columns.size(), maxRows);

        int baseX = anchor.getBlockX();
        int baseY = anchor.getBlockY();
        int baseZ = anchor.getBlockZ();

        for (int colIdx = 0; colIdx < columns.size(); colIdx++) {
            StatusColumn column = columns.get(colIdx);
            int colX = baseX + (colIdx * COLUMN_SPACING);

            List<JiraTicket> columnTickets = ticketsByStatus.getOrDefault(column.getJiraStatusName().toLowerCase(), Collections.emptyList());
            int ticketCount = columnTickets.size();
            int columnRows = (ticketCount + COLUMN_WIDTH - 1) / COLUMN_WIDTH;

            // Backing wall — extend to max rows so all columns have equal space
            for (int y = baseY + 1; y >= baseY - maxRows; y--) {
                for (int dx = 0; dx < COLUMN_WIDTH; dx++) {
                    Block backing = world.getBlockAt(colX + dx, y, baseZ - 1);
                    backing.setType(Material.OAK_PLANKS);
                }
            }

            // Column header sign
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

            // Place item frames in a grid: 2 wide x maxRows tall
            int ticketIdx = 0;
            for (int row = 0; row < maxRows; row++) {
                int frameY = baseY - row;
                for (int dx = 0; dx < COLUMN_WIDTH; dx++) {
                    Location frameLoc = new Location(world, colX + dx, frameY, baseZ);

                    ItemFrame frame = (ItemFrame) world.spawnEntity(frameLoc, EntityType.ITEM_FRAME);
                    frame.setFacingDirection(BlockFace.SOUTH);

                    if (ticketIdx < ticketCount) {
                        JiraTicket ticket = columnTickets.get(ticketIdx);
                        ItemStack book = createTicketBook(ticket);
                        frame.setItem(book);
                        boardManager.cacheTicketStatus(ticket.getKey(), column.getJiraStatusName());
                        ticketIdx++;
                    }

                    column.addFrameLocation(frameLoc);
                }
            }
        }
    }

    private ItemStack createTicketBook(JiraTicket ticket) {
        ItemStack book = new ItemStack(Material.WRITTEN_BOOK);
        BookMeta meta = (BookMeta) book.getItemMeta();

        String fullTitle = ticket.getKey() + ": " + ticket.getSummary();
        // Minecraft book titles are capped at 32 chars
        String bookTitle = fullTitle.length() > 32 ? fullTitle.substring(0, 32) : fullTitle;
        meta.setTitle(bookTitle);
        meta.setAuthor("Jira");
        meta.displayName(Component.text(fullTitle).color(getColorForType(ticket.getIssueType())));

        meta.addPages(Component.text(ticket.getKey() + "\n\n" + ticket.getSummary() + "\n\nType: " + ticket.getIssueType() + "\nStatus: " + ticket.getStatus()));

        String desc = ticket.getDescription();
        if (desc != null && !desc.isEmpty()) {
            for (int i = 0; i < desc.length(); i += 256) {
                String pageText = desc.substring(i, Math.min(i + 256, desc.length()));
                meta.addPages(Component.text(pageText));
            }
        }

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
