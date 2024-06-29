#!/usr/bin/env bash

. scripts/brew.sh
. scripts/utils.sh
. scripts/config.sh
. scripts/packages.sh
. scripts/language_tools.sh

# Inspirations:
# -- https://github.com/protiumx/.dotfiles

# - Postgres.app (http://postgresapp.com/)

info "Starting bootstrapping"

brew update

install_brew_packages

# Remove outdated versions from the cellar.
brew cleanup

OMZDIR="$HOME/.oh-my-zsh"
if [[ ! -d "$OMZDIR" ]]; then
    info 'Installing oh-my-zsh...'
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

info "Installing fonts..."
apply_brew_taps homebrew/cask-fonts
install_brew_casks font-fira-code

symlink_dotfiles

info "Installing language tools"
install_rust_tools
success "Installed language tools successfully"

# Change default shell
if [[ "$0" != "-zsh" ]]; then
    info 'Changing default shell to zsh...'
    chsh -s /bin/zsh
else
    info 'Already using zsh'
fi
