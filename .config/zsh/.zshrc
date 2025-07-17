export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export PATH=/opt/homebrew/bin:$PATH
export EDITOR='nvim'

autoload -U compinit && compinit

eval "$(sheldon source)"
compinit

bindkey -v

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

eval "$(starship init zsh)"
