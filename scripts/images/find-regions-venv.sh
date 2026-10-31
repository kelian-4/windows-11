#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/env.sh"
activate_venv
"$SCRIPT_DIR/find_regions.py" "$@"
deactivate_venv
