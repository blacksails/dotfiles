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

# setup znap
export ZNAP_REPOS=$XDG_DATA_HOME/znap
[[ -r "$ZNAP_REPOS" ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZNAP_REPOS/znap
source $ZNAP_REPOS/znap/znap.zsh

znap source ohmyzsh/ohmyzsh lib/completion
znap install zsh-users/zsh-completions

# config files
for file in $ZDOTDIR/conf.d/*.zsh; do
  . $file
done

. $ZDOTDIR/starship.zsh

autoload -U compinit&& compinit
