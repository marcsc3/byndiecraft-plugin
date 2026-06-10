#!/bin/bash

# Test script for MCP server
# Tests the /implement-ticket endpoint with a sample ticket

echo "=================================="
echo "Testing Byndiecraft MCP Server"
echo "=================================="
echo ""

# Check if server is running
if ! curl -s http://localhost:3000/health > /dev/null; then
    echo "❌ Error: Server is not running on http://localhost:3000"
    echo ""
    echo "Start the server with:"
    echo "  npm start"
    exit 1
fi

echo "✓ Server is running"
echo ""

# Test ticket
TICKET_KEY="TEST-123"
TICKET_SUMMARY="Add health check endpoint to API"
TICKET_DESCRIPTION="Implement a /health endpoint that returns service status"
JIRA_URL="https://bynder.atlassian.net/browse/TEST-123"
PLAYER_NAME="TestPlayer"

echo "Submitting test ticket:"
echo "  Key: $TICKET_KEY"
echo "  Summary: $TICKET_SUMMARY"
echo "  Player: $PLAYER_NAME"
echo ""

# Make request
RESPONSE=$(curl -s -X POST http://localhost:3000/implement-ticket \
    -H "Content-Type: application/json" \
    -d "{
        \"ticketKey\": \"$TICKET_KEY\",
        \"ticketSummary\": \"$TICKET_SUMMARY\",
        \"ticketDescription\": \"$TICKET_DESCRIPTION\",
        \"jiraUrl\": \"$JIRA_URL\",
        \"playerName\": \"$PLAYER_NAME\"
    }")

echo "Response:"
echo "$RESPONSE" | jq '.'
echo ""

# Check if successful
if echo "$RESPONSE" | jq -e '.success == true' > /dev/null; then
    echo "✓ Test successful!"
    PR_URL=$(echo "$RESPONSE" | jq -r '.prUrl')
    echo ""
    echo "PR URL: $PR_URL"
else
    echo "❌ Test failed"
    ERROR=$(echo "$RESPONSE" | jq -r '.error // "Unknown error"')
    echo "Error: $ERROR"
    exit 1
fi
