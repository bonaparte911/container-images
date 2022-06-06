#!/usr/bin/env bash

# fix Windows line-endings
sed $'s/\r$//' /shim/umask.sh > /shim/umask.sh
sed $'s/\r$//' /shim/vpn.sh > /shim/vpn.sh
sed $'s/\r$//' /shim/greeting.sh > /shim/greeting.sh

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"
source "/shim/greeting.sh"

FOO="${OSEMU_USER:=user}"  
FOO="${OSEMU_PASSWORD:=password}"

exec /app/OSEmu -a ${OSEMU_USER}:${OSEMU_PASSWORD} -c /config -p 11000 ${EXTRA_ARGS}
