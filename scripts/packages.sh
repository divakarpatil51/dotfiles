
install_brew_packages() {
	PACKAGES=(
			bottom     # https://github.com/ClementTsang/bottom
			stow
			coreutils
			findutils
			ack
			autoconf
			automake
			delve
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
			ripgrep
			rust-analyzer
			hugo
			sqlite
			tmux
			wget
			zsh-syntax-highlighting
			jq
			helix
			fd
			lazygit
			pyenv
			go
			httpie     # https://github.com/httpie/httpie
			k9s        # https://github.com/derailed/k9s
			kubernetes-cli
			postgresql
			zoxide     # https://github.com/ajeetdsouza/zoxide
	)

	info "Installing brew packages..."
	install_brew_formulas "${PACKAGES[@]}"
	success "Installed brew packages successfully"
}


install_brew_casks() {
	CASKS=(
			1password-cli
			alfred
			caffeine
			google-chrome
			arc
			kindle
			rectangle
			slack
			spotify
			visual-studio-code
			zoom
			ghostty
			kitty
			postgres-unofficial # App wrapper for Postgres.app
			font-fira-code
	)

	info "Installing brew casks..."
	install_brew_casks "${CASKS[@]}"
	success "Installed brew casks successfully"
}
