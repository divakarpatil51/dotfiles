
install_brew_packages() {
	PACKAGES=(
			stow
			coreutils
			findutils
			ack
			autoconf
			automake
			direnv
			fzf
			gettext
			gh
			grep
			git
			lua
			luajit
			luarocks
			memcached
			neovim
			rabbitmq
			rename
			tmux
			wget
			zsh-syntax-highlighting
			kitty
			jq
	)

	info "Installing brew packages..."
	# install_brew_formulas "${PACKAGES[@]}"
	success "Installed brew packages successfully"
}
