FROM alpine:latest

ENV WINEDEBUG=-all
ENV HOME=/root

COPY etc/apk/repositories /etc/apk/repositories
COPY usr/local/bin/bedrock_server_mod usr/local/bin/bedrock_server_mod

COPY usr/local/bin/cmd /usr/local/bin/cmd

RUN apk update  \
        && apk add wine font-wqy-zenhei bash

RUN wget -O /usr/local/bin/winetricks https://ghproxy.com/https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks  \
        && chmod a+x /usr/local/bin/winetricks

RUN chmod a+x /usr/local/bin/*

LABEL \
    org.opencontainers.image.authors="DiamondBlock <ZH15904837658@163.com>" \
    org.opencontainers.image.description="Wine container for LiteLoaderBDS server." \
    org.opencontainers.image.documentation="https://github.com/dmblock/LiteLoaderBDS-docker/README.md" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.source="git@github.com:dmblock/LiteLoaderBDS-docker.git" \
    org.opencontainers.image.title="Wine LiteloaderBDS" \
    org.opencontainers.image.url="https://github.com/dmblock/LiteLoaderBDS-docker" \
    org.opencontainers.image.vendor="DiamondBlock"
