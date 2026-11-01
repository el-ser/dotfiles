#!/usr/bin/env bash
# stow.sh — pick dotfile packages with fzf and stow them into $HOME.
#
# Usage:
#   ./stow.sh       stow the selected packages
#   ./stow.sh -n    dry run: show what would happen, change nothing
#
# In the picker: TAB toggles an item, CTRL-A toggles all, ENTER stows, ESC cancels.
# Everything is selected when the picker opens.

set -euo pipefail
shopt -s nullglob

# Folders that are not stow packages
EXCLUDE=("nix-darwin")

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

STOW_FLAGS="-R"
DRY_RUN=false
if [[ "${1:-}" == "-n" ]]; then
  STOW_FLAGS="-n -v -R"
  DRY_RUN=true
  echo "Dry run: nothing will be changed."
fi

for cmd in stow fzf; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "error: '$cmd' is not installed" >&2
    exit 1
  fi
done

cd "$DOTFILES_DIR"

# Collect packages: top-level, non-hidden folders, minus EXCLUDE
packages=()
for dir in */; do
  pkg="${dir%/}"
  skip=false
  for ex in "${EXCLUDE[@]}"; do
    if [[ "$pkg" == "$ex" ]]; then
      skip=true
      break
    fi
  done
  if [[ "$skip" == false ]]; then
    packages+=("$pkg")
  fi
done

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No packages found in $DOTFILES_DIR" >&2
  exit 1
fi

selected=$(printf '%s\n' "${packages[@]}" | fzf \
  --multi \
  --marker='✓ ' \
  --bind 'load:select-all' \
  --bind 'ctrl-a:toggle-all' \
  --header 'TAB: toggle · CTRL-A: toggle all · ENTER: stow · ESC: cancel' \
  --preview 'find {} -type f -not -name .DS_Store | sort' \
  --height 60% --reverse --border) || {
  echo "Cancelled."
  exit 0
}

to_stow=()
while IFS= read -r line; do
  if [[ -n "$line" ]]; then
    to_stow+=("$line")
  fi
done <<<"$selected"

# Make sure ~/.config exists, so stow links the folders inside it
# instead of linking the whole ~/.config to this repo
if [[ "$DRY_RUN" == false ]]; then
  mkdir -p "$HOME/.config"
fi

failed=()
for pkg in "${to_stow[@]}"; do
  # shellcheck disable=SC2086
  if stow $STOW_FLAGS -d "$DOTFILES_DIR" -t "$HOME" "$pkg"; then
    echo "✓ $pkg"
  else
    echo "✗ $pkg" >&2
    failed+=("$pkg")
  fi
done

if [[ ${#failed[@]} -gt 0 ]]; then
  echo >&2
  echo "Failed: ${failed[*]}" >&2
  echo "Usually an existing file is in the way. Move it aside and run again." >&2
  exit 1
fi

echo "Done."
