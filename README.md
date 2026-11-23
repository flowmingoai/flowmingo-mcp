# Flowmingo MCP server

Connect Claude, ChatGPT, Gemini, Cursor, VS Code or any MCP client to your [Flowmingo](https://flowmingo.ai) hiring data.
Flowmingo is a free AI hiring platform: AI interviews, CV screening, skills tests and an applicant tracking board. This
remote MCP server lets an AI assistant read your company's job posts, hiring projects, candidates and assessment results,
answer questions about your hiring in plain words, and prepare actions such as inviting, moving or rejecting candidates.

This repository holds no server code: the server is hosted by Flowmingo. It holds what the AI directories need to list it,
a Claude plugin, a Gemini CLI extension and setup notes for agents (`llms-install.md`).

- **Server URL:** `https://mcp.flowmingo.ai/mcp` (Streamable HTTP; there is no SSE endpoint)
- **Full setup guide for every client:** <https://flowmingo.ai/integration/mcp>
- **Official MCP Registry:** `ai.flowmingo/flowmingo` ([server.json](server.json))

## What you need

A Flowmingo company account (free) and an API key from **Settings → Integrations → API Keys**, created by an Owner or an
Admin. Tick **Read hiring data** and **Read candidates**; add **Manage pipeline** and **Invite candidates** for the
actions. A complete key starts with `fl_live_`, then the key's public name, a dot and a long secret.

## Sign in

- **OAuth (recommended):** add the server URL to your client. It registers itself (Dynamic Client Registration, PKCE) and
  opens a Flowmingo page where you paste your API key. The assistant never receives the key.
- **Static key:** send it as a header, `x-api-key: fl_YOUR_KEY` or `Authorization: Bearer fl_YOUR_KEY`.

## Quick start

**Claude (claude.ai, Claude Desktop, Cowork):** open **Plugins** (Desktop: **Settings → Customize → Connectors**),
click **Add → Add custom connector**, name it `Flowmingo`, paste the URL and click **Continue**, keep the detected
settings and click **Add**, then paste your key on the Flowmingo page.

**ChatGPT:** open **Plugins → Add → Add custom MCP server**, name it `Flowmingo`, paste the URL, keep **OAuth**, and under
**Advanced OAuth settings** untick `create_project` and `create_assessment` unless you want ChatGPT to create projects and
assessments. Tick the risk box, click **Create as a plugin**, then **Continue to Flowmingo** and paste your key.

**Claude Code:**

```bash
claude mcp add --transport http flowmingo https://mcp.flowmingo.ai/mcp
claude mcp login flowmingo
```

**Codex (CLI, IDE extension, ChatGPT desktop app):**

```bash
codex mcp add flowmingo --url https://mcp.flowmingo.ai/mcp
codex mcp login flowmingo
```

**Gemini CLI:** `gemini extensions install https://github.com/flowmingoai/flowmingo-mcp`, then run `gemini` and sign in
when asked.

**Cursor, VS Code, Windsurf, Zed, Cline, Continue, Antigravity:** see the guide, which has a snippet for each.

Verify it works: ask *"list my open jobs."*

## What the assistant can do

- **Read:** ask questions about your hiring data, list job posts, projects, assessments and the pipeline, read assessment
  results and scores, look up and compare candidates.
- **Act, with a person's approval:** invite candidates to an assessment, move them between stages, reject or remove
  applications. Anything that emails a candidate, every reject and every removal waits until a person approves it at a
  signed-in Flowmingo link; the assistant cannot approve it, and a yes typed in the chat does not count.
- **Small reversible changes:** notes, ratings, shortlist marks and tags, previewed first and undoable for 24 hours.
- **Create and publish (opt-in):** with two extra permissions switched on by an Owner or Admin, create hiring projects and
  assessments and publish, close or boost a job post.

Everything is scoped to your organisation. The API, webhooks and this MCP server are free on every Flowmingo plan.

## Security and privacy

- With OAuth the assistant gets a short-lived access token, never your key. To cut an assistant off, delete the API key
  you authorised it with in **Settings → Integrations → API Keys**.
- Data is scoped to your organisation: the assistant can never see another company's data.
- Every request to `/mcp` is Origin-checked, and each session is bound to the credential that opened it.
- Privacy policy: <https://flowmingo.ai/privacy-policy> · Support: contact@flowmingo.ai

## Contents

| Path | For |
| --- | --- |
| `.claude-plugin/plugin.json`, `.mcp.json`, `skills/` | the Claude plugin: the connector plus two skills for reviewing and acting on candidates |
| `gemini-extension.json`, `GEMINI.md` | the Gemini CLI extension |
| `llms-install.md` | setup steps an agent such as Cline can follow |
| `server.json` | the entry on the official MCP Registry (`ai.flowmingo/flowmingo`) |

## License

MIT, see [LICENSE](LICENSE).
