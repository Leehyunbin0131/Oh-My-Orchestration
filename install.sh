#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/skills/my-orchestration/SKILL.md"
DEST_DIR="${GEMINI_SKILLS_DIR:-$HOME/.gemini/config/skills}/my-orchestration"
DEST="$DEST_DIR/SKILL.md"

if [[ ! -f "$SRC" ]]; then
  echo "Error: source skill not found at $SRC" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

if [[ -f "$DEST" ]] && ! cmp -s "$SRC" "$DEST"; then
  BACKUP="${DEST}.bak.$(date +%Y%m%d%H%M%S)"
  cp "$DEST" "$BACKUP"
  echo "Backed up existing SKILL.md to $BACKUP"
fi

cp "$SRC" "$DEST"
echo "Installed Oh-My-Orchestration skill to $DEST"
