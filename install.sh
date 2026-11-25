#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_ROOT="${GEMINI_SKILLS_DIR:-$HOME/.gemini/config/skills}"

INSTALL_ORCH=1
INSTALL_DOCS=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Install Oh-My-Orchestration skills into ~/.gemini/config/skills/ (or $GEMINI_SKILLS_DIR).

Options:
  (default)       Install my-orchestration only (zero dependencies)
  --with-docs     Install both my-orchestration and optional write-docs
  --all           Alias for --with-docs
  --docs-only     Install optional write-docs only
  -h, --help      Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-docs|--all)
      INSTALL_ORCH=1
      INSTALL_DOCS=1
      shift
      ;;
    --docs-only)
      INSTALL_ORCH=0
      INSTALL_DOCS=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option '$1'" >&2
      usage >&2
      exit 1
      ;;
  esac
done

install_skill() {
  local name="$1"
  local src="$SCRIPT_DIR/skills/$name/SKILL.md"
  local dest_dir="$SKILLS_ROOT/$name"
  local dest="$dest_dir/SKILL.md"

  if [[ ! -f "$src" ]]; then
    echo "Error: source skill not found at $src" >&2
    exit 1
  fi

  mkdir -p "$dest_dir"

  if [[ -f "$dest" ]] && ! cmp -s "$src" "$dest"; then
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    cp "$dest" "$backup"
    echo "Backed up existing $name/SKILL.md to $backup"
  fi

  cp "$src" "$dest"
  echo "Installed $name skill to $dest"
}

if [[ "$INSTALL_ORCH" -eq 1 ]]; then
  install_skill "my-orchestration"
fi

if [[ "$INSTALL_DOCS" -eq 1 ]]; then
  install_skill "write-docs"
fi
