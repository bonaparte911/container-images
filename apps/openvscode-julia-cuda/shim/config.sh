#!/usr/bin/env bash

mkdir -p /config

echo "**** install extensions ****" && \
install-extension julialang.language-julia && \
install-extension bungcip.better-toml && \
