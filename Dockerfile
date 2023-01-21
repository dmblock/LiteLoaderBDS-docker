FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG='C.UTF-8' \
        LC_ALL='C.UTF-8' \
        TZ=Asia/Shanghai \
        HOME=/root

ENV WINEDEBUG=-all

RUN mv /etc/apt/sources.list /etc/apt/sources.bak \
        && echo 'nameserver 8.8.8.8' >> /etc/resolv.conf \
        && echo 'nameserver 223.5.5.5' >> /etc/resolv.conf

COPY etc/apt/sources.list /etc/apt/sources.list
COPY usr/share/keyrings/winehq-archive.key /usr/share/keyrings/winehq-archive.key
COPY winetricks /var/winetricks

RUN apt update \
        && apt install -y busybox software-properties-common ca-certificates openssl fonts-wqy-* xfonts-wqy cabextract gosu curl wget tzdata zip unzip \
        && apt autoremove -y \
        && apt clean \
        && rm -rf /tmp/*

RUN dpkg --add-architecture i386 \
        && echo 'deb [arch=amd64,i386 signed-by=/usr/share/keyrings/winehq-archive.key] https://mirrors.tuna.tsinghua.edu.cn/wine-builds/ubuntu/ focal main' > /etc/apt/sources.list.d/winehq.list \
        && apt update -y \
        && apt install -y --install-recommends winehq-stable

ARG GECKO_VERSION=2.47.3
ARG MONO_VERSION=7.4.0
RUN \
        mkdir -p /usr/share/wine/gecko \
        && mkdir -p /usr/share/wine/mono \
        && wget -O /usr/share/wine/gecko/wine-gecko-${GECKO_VERSION}-x86.msi "https://mirrors.ustc.edu.cn/wine/wine/wine-gecko/${GECKO_VERSION}/wine-gecko-${GECKO_VERSION}-x86.msi" \
        && wget -O /usr/share/wine/mono/wine-mono-${MONO_VERSION}-x86.msi "https://mirrors.ustc.edu.cn/wine/wine/wine-mono/${MONO_VERSION}/wine-mono-${MONO_VERSION}-x86.msi"
        
RUN wget -O /usr/local/bin/winetricks https://ghproxy.com/https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
        && chmod a+x /usr/local/bin/winetricks

RUN wine wineboot

RUN \
        rm -rf /usr/share/wine/gecko \
        && rm -rf /usr/share/wine/mono \
        && rm -rf  /home/user/.cache/* \
        && rm -rf /home/user/tmp/* \
        && rm -rf /tmp/* \
        && rm -rf /var/winetricks/*

COPY usr/local/bin/winescript usr/local/bin/winescript
RUN chmod a+x usr/local/bin/winescript

LABEL \
    org.opencontainers.image.authors="DiamondBlock <leefly2333@outlook.com>" \
    org.opencontainers.image.description="Wine container for LiteLoaderBDS server." \
    org.opencontainers.image.documentation="https://github.com/dmblock/LiteLoaderBDS-docker/README.md" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.source="git@github.com:dmblock/LiteLoaderBDS-docker.git" \
    org.opencontainers.image.title="Wine LiteloaderBDS" \
    org.opencontainers.image.url="https://github.com/dmblock/LiteLoaderBDS-docker" \
    org.opencontainers.image.vendor="DiamondBlock"
