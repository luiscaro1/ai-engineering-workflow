#!/usr/bin/env bash
# Installs this repo's skills into ~/.cursor/skills.
# Default: symlink each skill, so edits in either place stay in sync.
# --copy: copy instead, for setups that don't follow symlinks.
set -euo pipefail

mode="link"
if [[ "${1:-}" == "--copy" ]]; then
  mode="copy"
fi

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="$HOME/.cursor/skills"
backup="$HOME/.cursor/skills-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$target"

for skill in "$repo_dir"/skills/*/; do
  skill="${skill%/}"
  name="$(basename "$skill")"
  dest="$target/$name"

  if [[ -L "$dest" ]]; then
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    mkdir -p "$backup"
    mv "$dest" "$backup/"
    echo "Backed up existing $name to $backup/"
  fi

  if [[ "$mode" == "copy" ]]; then
    cp -R "$skill" "$dest"
  else
    ln -s "$skill" "$dest"
  fi
  echo "Installed $name ($mode)"
done

echo
echo "Skills installed. Start a new Cursor chat to pick them up."
echo "User Rules must be pasted manually into Cursor Settings > Rules > User Rules."
echo "To copy them to the clipboard on macOS: pbcopy < \"$repo_dir/user-rules.md\""
