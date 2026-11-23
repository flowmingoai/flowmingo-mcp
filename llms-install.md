# Installing the Flowmingo MCP server (for AI agents such as Cline)

Flowmingo's MCP server is **remote and hosted by Flowmingo**. There is nothing to clone, build or run: add one entry to the
client's MCP configuration.

- URL: `https://mcp.flowmingo.ai/mcp`
- Transport: Streamable HTTP. The server has **no SSE endpoint**, so a client that defaults to SSE must be told to use
  Streamable HTTP.
- Authentication: a Flowmingo API key as a header (`x-api-key: fl_...` or `Authorization: Bearer fl_...`), or OAuth with
  Dynamic Client Registration where the client supports it.

## Steps

1. Ask the user for their Flowmingo API key. They create it in Flowmingo under **Settings → Integrations → API Keys**
   (an Owner or Admin), with **Read hiring data** and **Read candidates** ticked, and **Manage pipeline** and **Invite
   candidates** for actions. A complete key looks like `fl_live_<name>.<secret>`: one value with a dot in it. A value
   without a dot is only the key's name and will be refused.
2. Add the server to the MCP settings. For Cline (MCP Servers → Configure → `cline_mcp_settings.json`):

```json
{
  "mcpServers": {
    "flowmingo": {
      "type": "streamableHttp",
      "url": "https://mcp.flowmingo.ai/mcp",
      "headers": { "Authorization": "Bearer fl_YOUR_KEY" },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

   Replace `fl_YOUR_KEY` with the user's complete key. `type` must be `streamableHttp` (camelCase); without it Cline
   uses SSE and the connection fails.
3. Keep the key out of version control: the settings file now holds a credential.
4. Verify: call the `whoami` tool. It returns the organisation id and the key's scopes. Then try `list_job_posts`.

## If it does not connect

- *Missing credential* or *The Flowmingo API key was rejected*: the header did not carry the complete key. Check the value.
- A 404 or a transport error: the URL must end in `/mcp`, and the transport must be Streamable HTTP.

Full guide for every client: <https://flowmingo.ai/integration/mcp>
