if command -v kubectl 2>&1 > /dev/null
then
    znap fpath _kubectl 'kubectl completion zsh'
    znap source ohmyzsh/ohmyzsh plugins/kubectl
fi

if command -v stern 2>&1 > /dev/null
then
    znap fpath _stern 'stern --completion zsh'
fi

if command -v flux 2>&1 > /dev/null
then
    znap fpath _flux 'flux completion zsh'
fi
