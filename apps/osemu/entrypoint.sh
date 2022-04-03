#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"
source "/shim/greeting.sh"

FOO="${OSEMU_USER:=user}"  
FOO="${OSEMU_PASSWORD:=password}"

exec /app/OSEmu -a ${OSEMU_USER}:${OSEMU_PASSWORD} -c /config -p 11000 ${EXTRA_ARGS}
