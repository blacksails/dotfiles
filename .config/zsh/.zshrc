# Path to dot files
export DOTCONF="$HOME/.config"

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Vi style line editing
bindkey -v
bindkey '^R' history-incremental-search-backward

# load zplug
source "$ZDOTDIR/zplug.zsh"

# load other config files
for file in $ZDOTDIR/conf.d/*.zsh; do
  source $file
done

autoload -U compinit&& compinit
