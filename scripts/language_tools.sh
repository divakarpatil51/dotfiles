
install_rust_tools() {

	info "Installing Rust tools"
	rustup-init
	source "$HOME/.cargo/env"

	if ! command -v rust-analyzer &>/dev/null; then
		info "Installing rust-analyzer"
		brew install rust-analyzer
	fi

}
