if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  echo "Activating venv"
  source "${VIRTUAL_ENV}/bin/activate"
fi
. "$HOME/.cargo/env"
