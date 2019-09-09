export ZPLUG_HOME=$XDG_DATA_HOME/zplug

source $ZPLUG_HOME/init.zsh

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug "lib/completion", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "docker/cli", as:plugin, use:"contrib/completion/zsh/_docker"

zplug load
