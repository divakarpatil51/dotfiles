
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
			rustup
			rust-analyzer
			terminal-notifier
			hugo
			ollama
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
			golang
			gopls
			httpie     # https://github.com/httpie/httpie
			k9s        # https://github.com/derailed/k9s
			kubernetes-cli
			postgresql
			uv
			zoxide     # https://github.com/ajeetdsouza/zoxide
			powerlevel10k
			zsh-autosuggestions
	)

	info "Installing brew packages..."
	install_brew_formulas "${PACKAGES[@]}"
	success "Installed brew packages successfully"
}


install_all_brew_casks() {
	CASKS=(
			1password-cli
			alfred
			anki
			caffeine
			google-chrome
			arc
			rectangle
			slack
			spotify
			visual-studio-code
			zoom
			ghostty
			kitty
			postgres-unofficial # App wrapper for Postgres.app
			font-fira-code
			raycast
			obsidian
			datagrip
			coscreen #https://www.coscreen.co/
			logseq
	)

	info "Installing brew casks..."
	install_brew_casks "${CASKS[@]}"
	success "Installed brew casks successfully"
}
