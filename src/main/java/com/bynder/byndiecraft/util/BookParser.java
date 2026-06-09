package com.bynder.byndiecraft.util;

import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BookParser {
    // Pattern to match Jira ticket keys (e.g., TAP-123, PROJ-456)
    private static final Pattern TICKET_KEY_PATTERN = Pattern.compile("([A-Z]+-\\d+)");

    public static Optional<String> extractTicketKey(String bookTitle) {
        if (bookTitle == null || bookTitle.trim().isEmpty()) {
            return Optional.empty();
        }

        Matcher matcher = TICKET_KEY_PATTERN.matcher(bookTitle);
        if (matcher.find()) {
            return Optional.of(matcher.group(1));
        }

        return Optional.empty();
    }

    public static boolean isValidTicketKey(String ticketKey) {
        if (ticketKey == null) {
            return false;
        }
        return TICKET_KEY_PATTERN.matcher(ticketKey).matches();
    }

    public static String formatBookTitle(String ticketKey, String summary) {
        if (summary == null || summary.isEmpty()) {
            return ticketKey;
        }
        return ticketKey + ": " + summary;
    }
}
