package com.bynder.byndiecraft.ai.models;

public class PRResult {
    private final boolean success;
    private final String prUrl;
    private final String error;
    private final String summary;

    private PRResult(boolean success, String prUrl, String error, String summary) {
        this.success = success;
        this.prUrl = prUrl;
        this.error = error;
        this.summary = summary;
    }

    public static PRResult success(String prUrl, String summary) {
        return new PRResult(true, prUrl, null, summary);
    }

    public static PRResult failure(String error) {
        return new PRResult(false, null, error, null);
    }

    public boolean isSuccess() {
        return success;
    }

    public String getPrUrl() {
        return prUrl;
    }

    public String getError() {
        return error;
    }

    public String getSummary() {
        return summary;
    }

    @Override
    public String toString() {
        if (success) {
            return String.format("PRResult[success, url=%s, summary=%s]", prUrl, summary);
        } else {
            return String.format("PRResult[failure, error=%s]", error);
        }
    }
}
