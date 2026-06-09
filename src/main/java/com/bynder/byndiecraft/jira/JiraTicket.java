package com.bynder.byndiecraft.jira;

public class JiraTicket {
    private final String key;
    private final String summary;
    private final String status;
    private final String statusId;

    public JiraTicket(String key, String summary, String status, String statusId) {
        this.key = key;
        this.summary = summary;
        this.status = status;
        this.statusId = statusId;
    }

    public String getKey() {
        return key;
    }

    public String getSummary() {
        return summary;
    }

    public String getStatus() {
        return status;
    }

    public String getStatusId() {
        return statusId;
    }

    @Override
    public String toString() {
        return String.format("%s: %s [%s]", key, summary, status);
    }
}
