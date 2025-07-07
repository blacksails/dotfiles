#!/usr/bin/env bash

set -e

# TODO: add xcode installation

script_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_DIR="${HOME}/.local/share"

# TODO: Clone dotfiles

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macos. Running macOS commands."
    source ${script_dir}/macos.sh
fi

source ${script_dir}/asdf.sh
