if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
fi
