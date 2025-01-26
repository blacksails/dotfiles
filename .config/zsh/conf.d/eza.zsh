if command -v eza 2>&1 > /dev/null
then
    alias ls='eza -lbF --git'
    alias l='eza -lbF --git'
    alias la='eza -labF --git'
    alias lg='eza'
    alias lga='eza -aG --git'
    alias ll='eza -lbhgUma --time-style=long-iso --git'
    alias lla='eza -labhgUma --time-style=long-iso --git'
fi
