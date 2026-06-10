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

    private static final int MAX_HEIGHT = 3; // 3 rows tall — visible in survival without looking up
    private static final int SEPARATOR_WIDTH = 1; // 1 empty block between columns

    private static final Material[] COLUMN_COLORS = {
            Material.WHITE_CONCRETE,
            Material.LIGHT_BLUE_CONCRETE,
            Material.YELLOW_CONCRETE,
            Material.PURPLE_CONCRETE,
            Material.LIME_CONCRETE
    };

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

    public void clearBoard(Location anchor, int totalWidth) {
        World world = anchor.getWorld();
        if (world == null) return;

        int startX = anchor.getBlockX();
        int startY = anchor.getBlockY();
        int startZ = anchor.getBlockZ();

        // Remove item frames in the area
        world.getEntities().stream()
                .filter(e -> e instanceof ItemFrame)
                .filter(e -> {
                    Location loc = e.getLocation();
                    return loc.getBlockX() >= startX - 1 && loc.getBlockX() < startX + totalWidth + 1
                            && loc.getBlockY() >= startY - 1 && loc.getBlockY() <= startY + MAX_HEIGHT + 2
                            && Math.abs(loc.getBlockZ() - startZ) <= 2;
                })
                .forEach(e -> e.remove());

        // Clear everything: backing, frames, decorations, floor, roof
        for (int x = startX - 1; x < startX + totalWidth + 1; x++) {
            for (int y = startY - 1; y <= startY + MAX_HEIGHT + 2; y++) {
                for (int dz = -1; dz <= 1; dz++) {
                    Block block = world.getBlockAt(x, y, startZ + dz);
                    if (block.getType() != Material.AIR) {
                        block.setType(Material.AIR);
                    }
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

        // Calculate width needed per column: ceil(ticketCount / MAX_HEIGHT) blocks wide, minimum 2
        int[] columnWidths = new int[columns.size()];
        for (int i = 0; i < columns.size(); i++) {
            int count = ticketsByStatus.getOrDefault(columns.get(i).getJiraStatusName().toLowerCase(), Collections.emptyList()).size();
            columnWidths[i] = Math.max(2, (count + MAX_HEIGHT - 1) / MAX_HEIGHT);
        }

        // Total board width
        int totalWidth = 0;
        for (int i = 0; i < columnWidths.length; i++) {
            totalWidth += columnWidths[i];
            if (i < columnWidths.length - 1) totalWidth += SEPARATOR_WIDTH;
        }

        clearBoard(anchor, totalWidth);

        int baseX = anchor.getBlockX();
        int baseY = anchor.getBlockY();
        int baseZ = anchor.getBlockZ();
        int topY = baseY + MAX_HEIGHT;

        // Floor base — dark oak slab platform
        for (int x = baseX - 1; x <= baseX + totalWidth; x++) {
            world.getBlockAt(x, baseY - 1, baseZ).setType(Material.DARK_OAK_SLAB);
            world.getBlockAt(x, baseY - 1, baseZ - 1).setType(Material.DARK_OAK_SLAB);
            world.getBlockAt(x, baseY - 1, baseZ + 1).setType(Material.DARK_OAK_SLAB);
        }

        int currentX = baseX;

        for (int colIdx = 0; colIdx < columns.size(); colIdx++) {
            StatusColumn column = columns.get(colIdx);
            int colWidth = columnWidths[colIdx];

            List<JiraTicket> columnTickets = ticketsByStatus.getOrDefault(column.getJiraStatusName().toLowerCase(), Collections.emptyList());
            int ticketCount = columnTickets.size();

            // Backing wall — colored concrete, fixed height
            Material wallMaterial = COLUMN_COLORS[colIdx % COLUMN_COLORS.length];
            for (int y = baseY; y <= topY; y++) {
                for (int dx = 0; dx < colWidth; dx++) {
                    Block backing = world.getBlockAt(currentX + dx, y, baseZ - 1);
                    backing.setType(wallMaterial);
                }
            }

            // Column header sign at the top center
            int signX = currentX + (colWidth / 2);
            Block signBlock = world.getBlockAt(signX, topY + 1, baseZ);
            signBlock.setType(Material.OAK_WALL_SIGN);
            org.bukkit.block.data.type.WallSign signData =
                    (org.bukkit.block.data.type.WallSign) signBlock.getBlockData();
            signData.setFacing(BlockFace.SOUTH);
            signBlock.setBlockData(signData);

            if (signBlock.getState() instanceof Sign sign) {
                sign.getSide(Side.FRONT).line(1, Component.text(column.getName()).color(NamedTextColor.DARK_BLUE));
                sign.update();
            }

            // Backing behind the sign
            world.getBlockAt(signX, topY + 1, baseZ - 1).setType(wallMaterial);

            column.getFrameLocations().forEach(column::removeFrameLocation);

            // Place item frames: fill columns top-to-bottom, then left-to-right
            int ticketIdx = 0;
            for (int dx = 0; dx < colWidth; dx++) {
                for (int row = 0; row < MAX_HEIGHT; row++) {
                    int frameY = baseY + (MAX_HEIGHT - 1 - row); // top to bottom
                    Location frameLoc = new Location(world, currentX + dx, frameY, baseZ);

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

            currentX += colWidth;

            // Separator pillar between columns
            if (colIdx < columns.size() - 1) {
                for (int y = baseY; y <= topY; y++) {
                    world.getBlockAt(currentX, y, baseZ - 1).setType(Material.DARK_OAK_LOG);
                }
                // Lantern on the pillar
                world.getBlockAt(currentX, baseY + 1, baseZ).setType(Material.LANTERN);
                currentX += SEPARATOR_WIDTH;
            }
        }

        // Top roof trim — spruce slab across the top
        for (int x = baseX - 1; x <= baseX + totalWidth; x++) {
            world.getBlockAt(x, topY + 2, baseZ - 1).setType(Material.SPRUCE_SLAB);
        }

        // Corner pillars with soul lanterns
        int leftPillarX = baseX - 1;
        int rightPillarX = baseX + totalWidth;
        for (int y = baseY; y <= topY + 2; y++) {
            world.getBlockAt(leftPillarX, y, baseZ - 1).setType(Material.DARK_OAK_LOG);
            world.getBlockAt(rightPillarX, y, baseZ - 1).setType(Material.DARK_OAK_LOG);
        }
        world.getBlockAt(leftPillarX, topY + 2, baseZ).setType(Material.SOUL_LANTERN);
        world.getBlockAt(rightPillarX, topY + 2, baseZ).setType(Material.SOUL_LANTERN);

        // Flower pots along the base
        for (int x = baseX; x < baseX + totalWidth; x += 3) {
            Block pot = world.getBlockAt(x, baseY, baseZ + 1);
            pot.setType(Material.POTTED_FERN);
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
