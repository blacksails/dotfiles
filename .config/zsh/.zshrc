export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export PATH=/opt/homebrew/bin:$PATH

# only build completions once a day
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' $ZDOTDIR/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

eval "$(sheldon source)"

bindkey -v

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

eval "$(starship init zsh)"
