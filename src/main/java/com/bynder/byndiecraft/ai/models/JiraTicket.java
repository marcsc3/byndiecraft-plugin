package com.bynder.byndiecraft.ai.models;

public class JiraTicket {
    private final String key;
    private final String summary;
    private final String description;
    private final String url;

    public JiraTicket(String key, String summary, String description, String url) {
        this.key = key;
        this.summary = summary;
        this.description = description;
        this.url = url;
    }

    public String getKey() {
        return key;
    }

    public String getSummary() {
        return summary;
    }

    public String getDescription() {
        return description;
    }

    public String getUrl() {
        return url;
    }

    @Override
    public String toString() {
        return String.format("JiraTicket[%s: %s]", key, summary);
    }
}
