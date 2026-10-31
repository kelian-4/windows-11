#!/usr/bin/env bash

export KEYRING_APPLICATION="windows-11"
export SHELL_CONFIG_DIR="${WINDOWS11_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/windows-11}"
export SHELL_CONFIG_FILE="$SHELL_CONFIG_DIR/config.json"

activate_venv() {
    local venv
    venv="$(eval echo "${WINDOWS11_VIRTUAL_ENV:-}")"
    if [[ -n "$venv" && -f "$venv/bin/activate" ]]; then
        # shellcheck source=/dev/null
        source "$venv/bin/activate"
    fi
}

deactivate_venv() {
    if declare -F deactivate >/dev/null; then
        deactivate
    fi
}
