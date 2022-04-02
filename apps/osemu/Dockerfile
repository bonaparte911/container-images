# hadolint ignore=DL3007
FROM ghcr.io/k8s-at-home/ubuntu:latest

ARG VERSION

USER root

# hadolint ignore=DL3008,DL3013,DL3015,SC2086
RUN \
  export EXTRA_INSTALL_ARG="build-essential git"; \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    ${EXTRA_INSTALL_ARG} \
  && \
  git clone --depth 1 https://github.com/oscam-emu/OSEmu /tmp/osemu \
  && cd /tmp/osemu \
  && make -j"$(nproc)" \
  && mv OSEmu /app/OSEmu \
  && \
  apt-get remove -y ${EXTRA_INSTALL_ARG} \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chown -R kah:kah /app \
  && chmod -R u=rwX,go=rX /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

USER kah

EXPOSE 11000/udp

COPY ./apps/osemu/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL \
  org.opencontainers.image.title="OSEmu" \
  org.opencontainers.image.source="https://github.com/oscam-emu/OSEmu" \
  org.opencontainers.image.version="${VERSION}"
