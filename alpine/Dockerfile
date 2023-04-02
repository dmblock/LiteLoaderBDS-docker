FROM alpine:latest

ENV WINEDEBUG=-all
ENV HOME=/root

COPY etc/apk/repositories /etc/apk/repositories
COPY usr/local/bin/bedrock_server_mod usr/local/bin/bedrock_server_mod

COPY usr/local/bin/cmd /usr/local/bin/cmd

RUN apk update  \
        && apk add wine font-wqy-zenhei bash

ARG GECKO_VERSION=2.47.3

RUN mkdir -p /usr/share/wine/gecko  \
        && wget -O /usr/share/wine/gecko/wine-gecko-${GECKO_VERSION}-x86_64.msi "https://mirrors.ustc.edu.cn/wine/wine/wine-gecko/${GECKO_VERSION}/wine-gecko-${GECKO_VERSION}-x86_64.msi"

RUN wget -O /usr/local/bin/winetricks https://ghproxy.com/https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks  \
        && chmod a+x /usr/local/bin/winetricks

RUN wine64 wineboot  \
        && wine64 --version

RUN rm -rf /usr/share/wine/gecko  \
        && rm -rf /home/user/.cache/*  \
        && rm -rf /home/user/tmp/*  \
        && rm -rf /tmp/* \
        && chmod a+x /usr/local/bin/*

LABEL \
    org.opencontainers.image.authors="DiamondBlock <ZH15904837658@163.com>" \
    org.opencontainers.image.description="Wine container for LiteLoaderBDS server." \
    org.opencontainers.image.documentation="https://github.com/dmblock/LiteLoaderBDS-docker/README.md" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.source="git@github.com:dmblock/LiteLoaderBDS-docker.git" \
    org.opencontainers.image.title="Wine LiteloaderBDS" \
    org.opencontainers.image.url="https://github.com/dmblock/LiteLoaderBDS-docker" \
    org.opencontainers.image.vendor="DiamondBlock"
