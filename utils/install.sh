#!/usr/bin/env bash
set -eo pipefail

XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

CANDYVIM_RUNTIME_DIR="${CANDYVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/candyvim"}"
CANDYVIM_CONFIG_DIR="${CANDYVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/cvim"}"
CANDYVIM_CACHE_DIR="${CANDYVIM_CACHE_DIR:-"$XDG_CACHE_HOME/cvim"}"

curl -s https://raw.githubusercontent.com/mrshmllow/CandyVim/main/utils/pretty/mountain.txt

echo "Installing CandyVim"

if [ ! -d "$CANDYVIM_RUNTIME_DIR/cvim" ]; then
  git clone https://github.com/mrshmllow/candyvim --depth 1 "$CANDYVIM_RUNTIME_DIR/cvim"
else
  git -C "$CANDYVIM_RUNTIME_DIR/cvim" pull
fi

echo "Installing packer.nvim"

rm -rf "$CANDYVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim"

if [ ! -d "$CANDYVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim/" ]; then
  git clone https://github.com/wbthomason/packer.nvim --depth 1 "$CANDYVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim/" --quiet
else
  git -C "$CANDYVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim/" pull
fi

echo "Copying files..."

source="$CANDYVIM_RUNTIME_DIR/cvim/utils/bin/cvim.template"
dest="$HOME/.local/bin/cvim"

rm -f "$dest"

cp "$source" "$dest"

sed -e s"#RUNTIME_DIR_VAR#\"${CANDYVIM_RUNTIME_DIR}\"#"g \
  -e s"#CONFIG_DIR_VAR#\"${CANDYVIM_CONFIG_DIR}\"#"g \
  -e s"#CACHE_DIR_VAR#\"${CANDYVIM_CACHE_DIR}\"#"g "$source" \
  | tee "$dest" > /dev/null

cp "$CANDYVIM_RUNTIME_DIR/cvim/utils/config.lua.template" "$XDG_CONFIG_HOME/config.lua"

echo "Updating Plugins..."

"$dest" --headless -c "autocmd User PackerComplete quitall" -c PackerSync &> /dev/null

