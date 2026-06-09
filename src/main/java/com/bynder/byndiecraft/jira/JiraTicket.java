package com.bynder.byndiecraft.jira;

public class JiraTicket {
    private final String key;
    private final String summary;
    private final String status;
    private final String statusId;
    private final String parentKey;
    private final String parentSummary;
    private final String issueType;
    private final String description;

    public JiraTicket(String key, String summary, String status, String statusId) {
        this(key, summary, status, statusId, null, null, null, null);
    }

    public JiraTicket(String key, String summary, String status, String statusId, String parentKey, String parentSummary) {
        this(key, summary, status, statusId, parentKey, parentSummary, null, null);
    }

    public JiraTicket(String key, String summary, String status, String statusId, String parentKey, String parentSummary, String issueType) {
        this(key, summary, status, statusId, parentKey, parentSummary, issueType, null);
    }

    public JiraTicket(String key, String summary, String status, String statusId, String parentKey, String parentSummary, String issueType, String description) {
        this.key = key;
        this.summary = summary;
        this.status = status;
        this.statusId = statusId;
        this.parentKey = parentKey;
        this.parentSummary = parentSummary;
        this.issueType = issueType;
        this.description = description;
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

    public String getParentKey() {
        return parentKey;
    }

    public String getParentSummary() {
        return parentSummary;
    }

    public String getIssueType() {
        return issueType;
    }

    public String getDescription() {
        return description;
    }

    public boolean hasParent() {
        return parentKey != null && !parentKey.isEmpty();
    }

    @Override
    public String toString() {
        return String.format("%s: %s [%s]", key, summary, status);
    }
}
