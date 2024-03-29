export ZPLUG_HOME=$XDG_DATA_HOME/zplug

source $ZPLUG_HOME/init.zsh

zplug "lib/completion", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/asdf", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

zplug load
