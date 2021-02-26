export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Vi style line editing
bindkey -v
bindkey '^R' history-incremental-search-backward

if [[ -f "$ZDOTDIR/secrets.zsh" ]]; then
  . "$ZDOTDIR/secrets.zsh"
fi

# load files required before plugins
for file in $ZDOTDIR/beforeplugins.conf.d/*.zsh; do
  . $file
done

# load zplug
. "$ZDOTDIR/zplug.zsh"

# load other config files
for file in $ZDOTDIR/conf.d/*.zsh; do
  . $file
done

autoload -U compinit&& compinit
