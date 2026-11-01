# ~/.zshrc: runs for interactive shells only.

# ---------- PATH ----------
typeset -U path PATH   # drop duplicates (safe to re-source this file)

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/bin:$PNPM_HOME:$PATH"
export PATH="$PATH:/opt/homebrew/opt/postgresql@13/bin"
export PATH="$PATH:$HOME/.rbenv/shims"

# ---------- History & keys ----------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# ---------- Completion ----------
autoload -Uz compinit
compinit

# ---------- Tools ----------
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(mise activate zsh)"
# eval "$(rbenv init - zsh)"
source <(fzf --zsh)
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Kubernetes: load every cluster config in ~/.kube/cluster
if [ -d "$HOME/.kube/cluster" ]; then
  export KUBECONFIG=$(find "$HOME/.kube/cluster" -type f -name '*.yaml' | paste -sd ':' -)
fi

# ---------- Aliases ----------
# git
alias ga="git add"
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias gcom="git commit -m"
alias gps="git push origin"
alias gpl="git pull origin"
alias glo="git log --oneline"
alias glo10="git log --oneline -n10 --graph"

# navigation
alias repo="cd ~/Documents/repositories"
alias dot="cd ~/dotfiles"
alias config="cd ~/.config"

# tools
alias lsf='nvim $(fzf -m --preview="bat --color=always {}")'
alias lv="NVIM_APPNAME=nvim-lazyvim nvim"
alias lvim="lv"
alias v="nvim"
alias vim="nvim"
alias lg="lazygit -ucf ~/.config/lazygit/config.yml"
alias ls="lsd -l --blocks permission,user,group,date,size,name --header"
alias k="kubectl"
alias kx="kubectx"
alias kn="kubens"
alias bwu='export BW_SESSION="$(bw unlock --raw)"'   # unlock Bitwarden for this shell
alias drb="sudo darwin-rebuild switch --flake ~/dotfiles/nix-darwin#el-ser"
alias reload-zsh="source ~/.zshrc"
