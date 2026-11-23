# ChatGPT plugin package

`plugin.json` and `mcp.json` in this folder are the ChatGPT plugin (Agent Plugins format) submitted at
platform.openai.com/plugins. The skills are the repository's own `skills/`, so the Claude plugin and this one never drift.

## Build the ZIP

From the repository root, on macOS or Linux:

```text
rm -rf /tmp/flowmingo-chatgpt && mkdir -p /tmp/flowmingo-chatgpt/assets dist
cp chatgpt/plugin.json chatgpt/mcp.json /tmp/flowmingo-chatgpt/
cp -R skills /tmp/flowmingo-chatgpt/skills
cp .claude-plugin/icon.png /tmp/flowmingo-chatgpt/assets/logo.png
cp .claude-plugin/icon.png /tmp/flowmingo-chatgpt/assets/icon.png
(cd /tmp/flowmingo-chatgpt && zip -q -r -X - plugin.json mcp.json skills assets) > dist/flowmingo-chatgpt-1.0.0.zip
```

Change `1.0.0` to the `version` in `plugin.json`. `dist/` is ignored by git; upload the ZIP, never commit it. Reviewer
credentials go in the OpenAI dashboard only, never in this folder.

(There is no build script on purpose: Claude's plugin directory refuses scripts from organisations it has not verified.)
