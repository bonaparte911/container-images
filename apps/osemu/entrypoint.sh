#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /app/OSEmu -c /config -p 11000 ${EXTRA_ARGS}
