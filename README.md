# CandyVIM

![image](https://user-images.githubusercontent.com/40532058/193812641-91a84aa0-496b-4b10-b97e-139e8aa4d1a4.png)

CandyVim is a WIP distribution of neovim. Right now, it is currently in alpha. It aims to be less of a framework for your own config but more of a complete daily driver package.

![image](https://user-images.githubusercontent.com/40532058/193812942-669eb9f7-c965-4ed8-b1cf-a8620e943f46.png)

![image](https://user-images.githubusercontent.com/40532058/193813404-b987875d-1240-4472-902d-71ce796d5322.png)

I created it because many people asked for my dotfiles and it got out of hand without a proper way to push updates.

## Install

CandyVim is in the AUR. [(Using amethyst of course)](https://github.com/crystal-linux/amethyst)

```bash
ame i candyvim-git
```

You can install it through a bash script although its not recommended since there is no updating method yet.

```bash
curl -s https://raw.githubusercontent.com/mrshmllow/CandyVim/main/utils/install.sh | bash
```

## Usage

Once your in CandyVim, hit "c" on your keyboard to enter your config.

## Development

Create this file structure:

```
~/Projects/CandyVim/
                    cvim/ -> https://github.com/mrshmllow/CandyVim (You edit here!)
                    site/pack/packer/start/packer.nvim/ -> https://github.com/wbthomason/packer.nvim
```

You can now run your dev version of CandyVim with

```bash
CANDYVIM_RUNTIME_DIR=~/Projects/CandyVim cvim
```

Note: You must have cvim installed. There isnt really a way to isolate them yet, but you could probably mess about with [`XDG_CONFIG_HOME`](https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories).

