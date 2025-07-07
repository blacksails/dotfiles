#!/usr/bin/env bash

export ASDF_CONFIG_DIR="${XDG_CONFIG_HOME}/asdf"
export ASDF_CONFIG_FILE="${ASDF_CONFIG_DIR}/asdfrc"
export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DATA_DIR="${ASDF_DIR}"

# Install asdf plugins
asdf plugin add golang
asdf plugin add nodejs

# Install global tool versions
asdf install
