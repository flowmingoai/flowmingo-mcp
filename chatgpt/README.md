# ChatGPT plugin package

`plugin.json` and `mcp.json` in this folder are the ChatGPT plugin (Agent Plugins format) submitted at
platform.openai.com/plugins. The skills are the repository's own `skills/`, so the Claude plugin and this one never drift.

## Build the ZIP

Make a folder holding, at its top level:

1. `plugin.json` and `mcp.json` from this folder;
2. a copy of the repository's `skills/` folder;
3. an `assets/` folder with the plugin icon from `.claude-plugin/` saved under the two names that `plugin.json` gives
   for `logo` and `composerIcon`.

Zip the folder's contents (not the folder itself) as `flowmingo-chatgpt-<version>.zip`, with the `version` from
`plugin.json`. Keep the ZIP in `dist/`, which git ignores: upload it, never commit it. Reviewer credentials go in the
OpenAI dashboard only, never in this folder.

(There is no build script on purpose: Claude's plugin directory refuses scripts from organisations it has not verified,
and holds a version whose text names an image file in a command.)
