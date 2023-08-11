if [ -f "${XDG_DATA_HOME}/google-cloud-sdk/path.zsh.inc" ]; then
  . "${XDG_DATA_HOME}/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "${XDG_DATA_HOME}/google-cloud-sdk/completion.zsh.inc" ]; then
  . "${XDG_DATA_HOME}/google-cloud-sdk/completion.zsh.inc" ]
fi

export CLOUDSDK_PYTHON=python3
