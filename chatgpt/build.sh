#!/bin/sh
# Builds the ChatGPT plugin ZIP (Agent Plugins format) for platform.openai.com/plugins.
# plugin.json and mcp.json live here; the skills are the repo's own, so the Claude plugin and this one never drift.
#   sh chatgpt/build.sh            -> dist/flowmingo-chatgpt-<version>.zip
set -eu
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/.." && pwd)
VERSION=$(node -e 'console.log(require(process.argv[1]).version)' "$HERE/plugin.json")
WORK=$(mktemp -d "${TMPDIR:-/tmp}/flowmingo-chatgpt.XXXXXX")
trap 'rm -rf "$WORK"' EXIT

mkdir -p "$WORK/assets"
cp "$HERE/plugin.json" "$HERE/mcp.json" "$WORK/"
cp -R "$ROOT/skills" "$WORK/skills"
cp "$ROOT/.claude-plugin/icon.png" "$WORK/assets/logo.png"
cp "$ROOT/.claude-plugin/icon.png" "$WORK/assets/icon.png"

mkdir -p "$ROOT/dist"
OUT="$ROOT/dist/flowmingo-chatgpt-$VERSION.zip"
rm -f "$OUT"
(cd "$WORK" && zip -q -r -X "$OUT" plugin.json mcp.json skills assets)
echo "$OUT"
