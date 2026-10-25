#!/bin/sh
# Launch the MCP server with Amazon credentials read from the macOS Keychain.
# One-time setup (prompts for the password, so it never lands in shell history):
#   security add-generic-password -s amazon-order-mcp -a 'you@example.com' -w
set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"
SERVICE="amazon-order-mcp"

AMAZON_USERNAME="$(security find-generic-password -s "$SERVICE" | sed -n 's/.*"acct"<blob>="\(.*\)"$/\1/p')"
AMAZON_PASSWORD="$(security find-generic-password -s "$SERVICE" -w)"
export AMAZON_USERNAME AMAZON_PASSWORD

exec "$DIR/.venv/bin/python" "$DIR/amazon_order_mcp.py"
