#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/env.sh"
activate_venv
GIO_USE_VFS=local "$SCRIPT_DIR/thumbgen.py" "$@"
THUMBGEN_EXIT_CODE=$?
deactivate_venv

exit $THUMBGEN_EXIT_CODE
