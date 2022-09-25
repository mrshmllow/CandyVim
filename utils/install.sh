#!/usr/bin/env bash
set -eo pipefail

declare INSTALL_PATH="$HOME/.local/share/candyvim_new"

XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

CANDYVIM_RUNTIME_DIR="${CANDYVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/candyvim_new"}"
CANDYVIM_CONFIG_DIR="${CANDYVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/cvim"}"
CANDYVIM_CACHE_DIR="${CANDYVIM_CACHE_DIR:-"$XDG_CACHE_HOME/cvim"}"

echo "Installing CandyVim"

if [ ! -d "$INSTALL_PATH" ]; then
  git clone https://github.com/mrshmllow/candyvim "$INSTALL_PATH/cvim"
else
  git -C "$INSTALL_PATH" pull
fi

echo "Copying files..."

source="$INSTALL_PATH/cvim/utils/bin/cvim.template"
dest="$HOME/.local/bin/cvim"

rm -f "$dest"

cp "$source" "$dest"

sed -e s"#RUNTIME_DIR_VAR#\"${CANDYVIM_RUNTIME_DIR}\"#"g \
  -e s"#CONFIG_DIR_VAR#\"${CANDYVIM_CONFIG_DIR}\"#"g \
  -e s"#CACHE_DIR_VAR#\"${CANDYVIM_CACHE_DIR}\"#"g "$source" \
  | tee "$dest" > /dev/null

echo "Updating Plugins..."

cvim --headless -c "autocmd User PackerComplete quitall" -c PackerSync

