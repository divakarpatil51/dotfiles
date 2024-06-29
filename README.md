# Divakar’s dotfiles

Scripts and configs to setup dev env on a new MacOS machine. Uses [stow](https://www.gnu.org/software/stow/) for symlinking dotfiles.

## Installation:
Download and run this script:
```
curl -sO https://raw.githubusercontent.com/divakarpatil51/dotfiles/main/dotfiles
```

The script should do roughly the following:

- Install brew, git if not installed already
- Install some useful packages & casks via brew.
- Symlink a bunch of config files found in this repo to the relevant places via stow.
- Configure some OSX settings.
- Configure nvim, kitty, and tmux

## Folder Structure:
- `configs/`: This folder hosts all the config files. This is structured as per the requirement of `stow` symlink manager.
- `scripts/`: Auxiliary code to help with installation.
- `bootstrap.sh`: Installation bootstrapping Script 
- `dotfiles`: Initiate the installation process.


## Testing symlinks:
Correctness of symlinks can be verified by running below command:
```
stow -nSv vim
```
