
install_rust_tools() {

	if ! command -v rustup &>/dev/null; then
		warn "Rust not installed."
	else
		info "Installing Rust tools"
		source "$HOME/.cargo/env"

		if ! command -v rust-analyzer &>/dev/null; then
			info "Installing rust-analyzer"
			brew install rust-analyzer
		fi
	fi

}
