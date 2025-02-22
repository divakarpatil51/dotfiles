symlink_dotfiles(){

	info "Symlinking config files with stow..."

	# Create the folders to avoid symlinking folders
	folders=(
			".config/nvim"
			".config/kitty"
			".config/tmux"
			".config/ghostty"
			".config/helix"
	)
	for d in "${folders[@]}"; do
			rm -rf "${HOME:?}/$d" || true
			mkdir -p "$HOME/$d"
	done

	# Stow automates the process of creating symbolic links to files and directories
	stow -d configs --verbose 1 --target "$HOME" kitty nvim tmux vim zsh ghostty helix
	success "Symlinking successful..."
}
