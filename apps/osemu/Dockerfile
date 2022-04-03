# hadolint ignore=DL3007
FROM ghcr.io/k8s-at-home/alpine:latest

ARG VERSION
ENV UMASK=0002

USER root

RUN \
  adduser -u 568 -SDH kah kah &&\
  mkdir -p /config /app &&\
  chown -R kah. /config /app &&\
  chmod -R 775 /config &&\
  chmod -R u=rwX,go=rX /app

# hadolint ignore=DL3008,DL3013,DL3015,SC2086
RUN \
  echo "**** install build packages ****" &&\
  apk -q update &&\
  apk add -q --no-cache --virtual=build-dependencies \
    build-base \
    git \
  && \
  echo "**** compile OSEmu ****" &&\
  git clone --depth 1 https://github.com/oscam-emu/OSEmu /tmp/osemu &&\
  cd /tmp/osemu &&\
  make -j"$(nproc)" &&\
  cd /tmp/osemu &&\
  cp OSEmu /app/OSEmu &&\
  echo "**** clean up ****" &&\
  apk del --purge build-dependencies &&\
  rm -rf \
    /tmp/osemu \
    /var/tmp/ \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

VOLUME [ "/config" ]
EXPOSE 11000/udp

COPY ./apps/osemu/shim /shim
COPY ./apps/osemu/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
  chown -R kah. /entrypoint.sh
RUN chmod +x /shim/* &&\
    chown -R kah. /shim

USER kah

CMD ["/entrypoint.sh"]

LABEL \
  org.opencontainers.image.title="OSEmu" \
  org.opencontainers.image.source="https://github.com/oscam-emu/OSEmu" \
  org.opencontainers.image.version="${VERSION}"
