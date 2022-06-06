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

if [ -n "$CONNECTION_SECRET" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} --connection-secret ${CONNECTION_SECRET}"
    echo "Using connection secret from ${CONNECTION_SECRET}"
elif [ -n "$CONNECTION_TOKEN" ]; then
    EXTRA_ARGS="${EXTRA_ARGS} --connection-token ${CONNECTION_TOKEN}"
    echo "Using connection token ${CONNECTION_TOKEN}"
else
    EXTRA_ARGS="${EXTRA_ARGS} --without-connection-token"
    echo "**** No connection token is set ****"
fi
   
exec /app/openvscode-server/bin/openvscode-server \
        --host 0.0.0.0 \
        --port 3000 \
        --disable-telemetry \
        ${EXTRA_ARGS}
