export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Vi style line editing
bindkey -v
bindkey '^R' history-incremental-search-backward

# load files required before plugins
for file in $ZDOTDIR/beforeplugins.conf.d/*.zsh; do
  source $file
done

# load zplug
source "$ZDOTDIR/zplug.zsh"

# load other config files
for file in $ZDOTDIR/conf.d/*.zsh; do
  source $file
done

autoload -U compinit&& compinit
