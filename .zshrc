# Created by newuser for 5.9
source <(fzf --zsh)
# History: persist across sessions, share between open terminals
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# Completion
autoload -Uz compinit && compinit

# Aliases (same as in .bashrc)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export ANTHROPIC_MODEL="claude-opus-5-5"
. "$HOME/.local/bin/env"

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

eval "$(starship init zsh)"

# zoxide: "z <dir>" jumps to frequently used directories
eval "$(zoxide init zsh)"

# direnv: loads a project's .envrc on cd (e.g. `layout uv` activates its .venv)
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Plugins (syntax highlighting must stay last)
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
