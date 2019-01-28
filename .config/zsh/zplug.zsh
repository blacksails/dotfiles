export ZPLUG_HOME=$HOME/.local/share/zplug

source $ZPLUG_HOME/init.zsh

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/kubectl", from:oh-my-zsh

zplug load
