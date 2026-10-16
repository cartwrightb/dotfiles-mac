# Keep history outside the repository and append commands as they are entered.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY HIST_IGNORE_DUPS

# Non-login shells also need Homebrew's completion directory.
typeset -U fpath
if [[ -d "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh/site-functions" ]]; then
    fpath=("${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh/site-functions" "${fpath[@]}")
fi
autoload -Uz compinit
compinit

# Use fzf's supplied bindings and completion without custom generators.
if (( $+commands[fzf] )); then
    source <(fzf --zsh)
fi

alias ll='ls -lah'
alias lt='eza --tree --level=2'

# Preserve the existing Starship prompt and its separate configuration.
eval "$(starship init zsh)"

# Private and host-specific overrides always take precedence.
if [[ -r "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
