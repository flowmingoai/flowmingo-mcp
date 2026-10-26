# Flowmingo MCP Server

Connect any MCP-compatible AI assistant (Claude, Claude Code, ChatGPT, Cursor, VS Code, Gemini and others) to your
[Flowmingo](https://flowmingo.ai) hiring data, and work your pipeline in plain language.

Flowmingo is a free AI Interviewer and screening platform for recruiters. This repository documents its **hosted
(remote) MCP server**. There is nothing to install or run: point your client at the URL below.

- **Server URL:** `https://mcp.flowmingo.ai/mcp`
- **Transport:** Streamable HTTP (no legacy SSE: always use `/mcp`, never `/sse`)
- **Official MCP Registry:** `ai.flowmingo/flowmingo` ([server.json](server.json))
- **Full docs:** https://flowmingo.ai/integration/mcp

## Authentication

**A. Sign in with Flowmingo (OAuth, recommended).** Your browser opens a Flowmingo consent page and you paste your
API key there once. The assistant only stores a short-lived access token, never your raw key. There is no client ID
or secret to create (Dynamic Client Registration); leave those fields blank if your client shows them.

**B. Static API key (header).** Send your key as either header:

```
x-api-key: fl_YOUR_KEY
Authorization: Bearer fl_YOUR_KEY
```

Get a key in Flowmingo: **Settings → Integrations → API Keys**. Tick *Read hiring data* and *Read candidates*;
add *Manage pipeline* / *Invite candidates* for the guarded write actions. Treat the key like a password and never
commit it to git.

## What you can do

Reads return immediately. Writes always preview the change and ask you to confirm inside the client first.
Everything is scoped to your organisation.

**Read**

| Capability | What it does |
|---|---|
| List job posts | Browse your organisation's open and closed roles |
| List interview sets & projects | See your interview sets and hiring projects |
| List your candidate pipeline | View applications by stage across a project |
| Read interview results & scores | Pull a candidate's interview outcome and scores |
| Look up a candidate | Fetch one candidate's name, email and CV |
| Search candidates | Find candidates by name or email |
| Compare candidates | Line up several candidates side by side |
| Hiring overview | Candidates per stage, completed vs in progress, average score |
| Top candidates | The highest-ranked candidates by interview score |
| Interview result detail | One interview's per-competency scores plus the AI summary |
| Job post detail | The full detail of a single job post |
| Upcoming interviews | Interviews scheduled or invited and not yet completed |

**Write (guarded: preview, then confirm)**

| Capability | What it does |
|---|---|
| Invite a candidate to an interview | Previews the invite, then asks you to confirm |
| Move a candidate to another stage | Previews the stage change, then asks you to confirm |
| Reject an application | Previews the rejection, then asks you to confirm |
| Add a note to a candidate | Previews the note, then asks you to confirm |
| Rate a candidate | Previews the rating, then asks you to confirm |
| Shortlist a candidate | Previews the shortlist change, then asks you to confirm |
| Tag / add to talent collection | Previews the change, then asks you to confirm |

## Connect your assistant

**Claude Code** (flags go before the name)

```bash
claude mcp add --transport http flowmingo https://mcp.flowmingo.ai/mcp
claude mcp login flowmingo   # browser opens; paste your fl_ key on the consent page
```

**Cursor** (`~/.cursor/mcp.json`; OAuth, opens a consent page on first connect)

```json
{
  "mcpServers": {
    "flowmingo": {
      "url": "https://mcp.flowmingo.ai/mcp"
    }
  }
}
```

**Any stdio-only client (via mcp-remote)**

```bash
npx -y mcp-remote https://mcp.flowmingo.ai/mcp --transport http-only
```

Steps for VS Code, Claude, ChatGPT, Gemini CLI, Codex and others: https://flowmingo.ai/integration/mcp

## Security

- Data is org-scoped: the assistant can never see another company's data.
- The assistant never receives your API key; it gets an access token that expires after an hour.
- To cut an assistant off, delete the API key you authorised it with (Settings → Integrations → API Keys).
- Every request is Origin-checked, and each session is bound to the credential that opened it.

## Support

contact@flowmingo.ai · https://flowmingo.ai
