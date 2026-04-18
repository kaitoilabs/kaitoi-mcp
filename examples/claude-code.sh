#!/usr/bin/env bash
# Connect Claude Code to the Kaitoi Studio MCP server.
#
# Mint your personal token inside Kaitoi Studio → Settings → MCP
# and paste it in place of YOUR_TOKEN below.

claude mcp add --transport http kaitoi-studio \
  https://mcp.studio.kaitoi.io \
  --header "Authorization: Bearer YOUR_TOKEN"

# Verify:
#   ask Claude Code → "Use Kaitoi Studio to list my projects."
