# Kaitoi Studio MCP Server

> **AI changed creation. Kaitoi changes production.**

Kaitoi Studio is a hybrid intelligence platform for creative work — a visual canvas where you design workflows that adapt to your vision, then scale them into real production pipelines.

This MCP server exposes Kaitoi Studio's workflow engine to your AI agent. Build a color-grade pipeline from Claude. Have Cursor wire a Fal video model into an existing graph. Ask your agent to scaffold a custom node, validate it, and drop it onto your canvas. Your agent and you share one workspace — the same canvas you work in visually.

> Kaitoi Studio is currently in **Private Beta**. [Join the waitlist →](https://kaitoi.io/studio)

---

## What You Can Do

Connect your AI agent (Claude Code, Claude Desktop, Cursor, VS Code, Windsurf, or any MCP client) to Kaitoi Studio and drive your creative pipelines from a conversation.

### Run workflows
- **`run_node`** — Execute a single node and wait for its output
- **`run_graph`** — Execute the full graph or a target subset of nodes
- **`validate_graph`** — Surface errors and missing connections before you run

### Build graphs programmatically
- **`add_node`** — Drop any node from the library onto your canvas
- **`connect_nodes`** / **`disconnect_nodes`** — Wire outputs to inputs
- **`update_node`** — Change inputs, parameters, prompts
- **`delete_node`** / **`clear_graph`** — Prune or reset

### Discover nodes
- **`search_nodes`** — Semantic + lexical search across builtin, user, and community nodes
- **`list_packages`** / **`get_package`** / **`list_package_files`** / **`read_package_file`** — Browse node packages

### Inspect state
- **`get_graph_state`** — Full structure: nodes, connections, parameters
- **`get_node_info`** — Details of a single node
- **`get_node_output`** — Fetch outputs from a node that already ran
- **`get_app_health`** — System status

### Manage projects
- **`list_projects`** / **`load_project`** / **`save_project`** — Persist and recall workflows

### Work with files and assets
- **`browse_library`** — Search your uploaded files by folder, keyword, or data type
- **`upload_file`** — Ingest a file from a URL into your Library
- **`read_file`** / **`write_file`** / **`update_file`** — Edit custom node scripts and other project files

### Author custom nodes
- **`get_node_code`** — Read the source of any node on your canvas
- **`validate_node_script`** — Syntax and schema check against Kaitoi's node spec
- **`search_user_scripts`** — Find your custom nodes

### Research from inside the agent
- **`get_fal_docs`** — Fetch documentation for any fal.ai endpoint (OpenAPI, markdown, and client snippets)
- **`web_search`** — Web search that returns URLs, titles, and snippets
- **`crawl_url`** — Clean markdown extraction with optional screenshot and link graph

**Plus:** 10 knowledge resources (node development, runtime API, data types, graph operations, troubleshooting, platform capabilities) and 3 expert prompts (`build_computational_workflow`, `create_custom_node`, `debug_workflow_issues`) your agent can invoke on demand.

---

## Why This Matters

Kaitoi Studio gives your agent something more useful than a single model endpoint: a graph of nodes it can search, compose, and run. Instead of picking one provider and one output type at a time, your agent can work inside a reusable workflow system that already knows how to generate, transform, and combine different kinds of media.

**Any provider or model can become part of the workflow.** Kaitoi graphs can mix nodes backed by Fal.ai, OpenAI, Anthropic, Google Gemini, OpenRouter, Stability AI, Replicate, Runway, Tripo3D, ElevenLabs, Freepik, Ollama, ComfyUI, and more. Through MCP, your agent can search for the right nodes, wire them together, tune parameters, validate the graph, and run the whole pipeline from one place.

**Workflows are reusable, not one-off prompts.** Your agent can load existing Kaitoi projects, build on top of established graph patterns, edit custom nodes, and save the result back into the same workspace you use visually. That makes it useful for repeatable creative systems, not just single generations.

**The output surface is broad.** Kaitoi workflows can create and process images, video, audio, 3D assets, documents and PDFs, web apps, embeddings, plots, and other structured outputs. The MCP server gives your agent access to that whole environment instead of a narrow "generate image" or "generate video" API.

---

## Quick Start

**1. Get a Kaitoi Studio account.** [Join the waitlist](https://kaitoi.io/studio) if you're not in the beta yet.

**2. Generate your connection command.** In Kaitoi Studio, open **Settings → MCP**. Pick your client (Claude Code, Claude Desktop, Cursor, VS Code, Windsurf, ...). The app generates the exact command or config block for your platform, with a freshly minted API token.

**3. Paste it into your client.**

Claude Code:

```bash
claude mcp add --transport http kaitoi-studio \
  https://mcp.studio.kaitoi.io \
  --header "Authorization: Bearer YOUR_TOKEN"
```

Cursor / VS Code / any MCP client with native remote HTTP support:

```json
{
  "mcpServers": {
    "kaitoi-studio": {
      "url": "https://mcp.studio.kaitoi.io",
      "headers": {
        "Authorization": "Bearer YOUR_TOKEN"
      }
    }
  }
}
```

Claude Desktop (via the `mcp-remote` bridge, until native remote HTTP lands in your install):

```json
{
  "mcpServers": {
    "kaitoi-studio": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote",
        "https://mcp.studio.kaitoi.io",
        "--header",
        "Authorization: Bearer YOUR_TOKEN"
      ]
    }
  }
}
```

**4. Verify.** Ask your agent: *"Use Kaitoi Studio to list my projects."*

Additional config snippets live in [`examples/`](./examples).

---

## Example Usage

**"Grade this render."**
> *"Load my `Trailer_v3` project in Kaitoi Studio, add a ColorGrade node after the VideoRender, lift the shadows to 1.05 and pull gamma to 0.92, run the graph, and give me the output path."*

Your agent loads the project, adds and wires the node, runs the graph, and returns the ProRes file path — in one turn.

**"Find me the right Fal model and wire it in."**
> *"I need a fast image-to-video model on Fal with lip-sync. Search Fal docs, pick one, add it to my current graph with inputs from the `CastingShot` node, and run a test render."*

The agent calls `get_fal_docs`, `search_nodes`, `add_node`, `connect_nodes`, and `run_node` in sequence.

**"Scaffold a custom node for me."**
> *"Write a node that takes a batch of images and applies a LUT from my Library. Validate it against the node spec, then drop it into my pipeline after the ImageBatch node."*

The agent writes the script, calls `validate_node_script`, saves it, and adds it to the canvas.

---

## Configuration

| Item | Value |
|---|---|
| Transport | Streamable HTTP |
| Endpoint | `https://mcp.studio.kaitoi.io` |
| Auth | Bearer token (generated in-app) |
| Token lifetime | 365 days by default, revocable anytime |
| Scope | Per-user — each token only sees the workspace of the user who minted it |

Tokens are minted and revoked in Kaitoi Studio under **Settings → MCP**. Mint a separate token per client (Claude Code, Cursor, ...) so you can revoke any of them without affecting the others.

---

## Requirements

- A Kaitoi Studio account (currently Private Beta — [waitlist](https://kaitoi.io/studio))
- An MCP client with remote HTTP server support:
  - Claude Code (native)
  - Cursor (native)
  - VS Code with an MCP-capable extension
  - Claude Desktop (via Custom Connectors, or the `mcp-remote` bridge)
  - Windsurf, Zed, and other MCP-compatible clients — consult your client's docs for remote-HTTP specifics

No local install, no runtime, no self-hosting. The server is hosted by Kaitoi Labs.

---

## Links

- **Product:** [kaitoi.io/studio](https://kaitoi.io/studio)
- **Company:** [kaitoi.io/labs](https://kaitoi.io/labs)
- **Discord:** [discord.gg/3A5YfXnCH](https://discord.gg/3A5YfXnCH)
- **Waitlist:** [kaitoi.io/studio](https://kaitoi.io/studio)

---

## About Kaitoi Labs

Kaitoi Labs, Inc. is a San Francisco–based team building hybrid intelligence tools for creative production. Our background spans AI, filmmaking, VFX, and product design. We believe the most powerful tools don't replace intuition — they amplify it.

## License

The contents of this repository are released under the [MIT License](./LICENSE). Access to the Kaitoi Studio MCP server itself is governed by the Kaitoi Studio terms of service.
