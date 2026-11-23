# ~/.zshenv: runs for EVERY zsh, including scripts.
# Keep it to plain variables and quick [[ -d/-f ]] checks: no PATH changes,
# no $(commands), no output.
# PATH lives in .zshrc, because macOS reorders PATH after this file runs.

# Editor (git and lazygit use these)
export EDITOR=nvim
export VISUAL=nvim

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

# Claude Code
export CLAUDE_CONFIG_DIR="$HOME/.config/claude"

# Opencode
export OPENCODE_CONFIG="$HOME/.config/opencode/opencode.json"

# Schema repo (only on Macs where it's cloned)
if [[ -d "$HOME/Documents/repositories/schema" ]]; then
  export SCHEMA_PATH="$HOME/Documents/repositories/schema"
fi

