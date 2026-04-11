#!/usr/bin/env bash
# Install the bfw brainstorm skill into Claude Code.
#
# Default target: ~/.claude/skills/brainstorm/  (user-level, available
# in every Claude Code session).
#
# Override with `--project` to install into the current project's
# .claude/skills/brainstorm/ instead.
set -euo pipefail

MODE="user"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --user)    MODE="user"; shift ;;
    --project) MODE="project"; shift ;;
    -h|--help)
      cat <<EOF
Usage: $0 [--user|--project]

  --user     Install into ~/.claude/skills/brainstorm/ (default)
  --project  Install into ./.claude/skills/brainstorm/
EOF
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BFW_ROOT="$(dirname "$SCRIPT_DIR")"

if [[ "$MODE" == "user" ]]; then
  TARGET="$HOME/.claude/skills/brainstorm"
else
  TARGET="$PWD/.claude/skills/brainstorm"
fi

echo "▸ Installing bfw into: $TARGET"
mkdir -p "$TARGET"
cp "$BFW_ROOT/SKILL.md" "$TARGET/SKILL.md"
cp "$BFW_ROOT/techniques.md" "$TARGET/techniques.md"

echo "✓ Installed. Test with: /brainstorm TOPIC=\"test topic\" DURATION=5"
