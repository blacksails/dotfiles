export ASDF_CONFIG_DIR="${XDG_CONFIG_HOME}/asdf"
export ASDF_CONFIG_FILE="${ASDF_CONFIG_DIR}/asdfrc"
export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DATA_DIR="${ASDF_DIR}"
source $ASDF_DIR/asdf.sh

# Setup java if plugin is enabled
if [ -f $ASDF_DIR/plugins/java/set-java-home.zsh ]; then
  . $ASDF_DIR/plugins/java/set-java-home.zsh
fi

znap source ohmyzsh/ohmyzsh plugins/asdf
