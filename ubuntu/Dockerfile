FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV WINEDEBUG=-all

COPY etc/apt/sources.list /etc/apt/sources.list
COPY usr/share/keyrings/winehq-archive.key /usr/share/keyrings/winehq-archive.key

RUN apt update \
        && apt install -y language-pack-zh-hans busybox software-properties-common ca-certificates openssl fonts-wqy-* xfonts-wqy cabextract gosu curl wget tzdata zip unzip \
        && apt autoremove -y \
        && apt clean \
        && rm -rf /tmp/*

ENV HOME=/root \
        TZ=Asia/Shanghai \
        LANG="zh_CN.UTF-8" \
        LANGUAGE="zh_CN:zh" \
        LC_NUMERIC="zh_CN" \
        LC_TIME="zh_CN" \
        LC_MONETARY="zh_CN" \
        LC_PAPER="zh_CN" \
        LC_NAME="zh_CN" \
        LC_ADDRESS="zh_CN" \
        LC_TELEPHONE="zh_CN" \
        LC_MEASUREMENT="zh_CN" \
        LC_IDENTIFICATION="zh_CN" \
        LC_ALL="zh_CN.UTF-8"

RUN dpkg --add-architecture i386 \
        && echo 'deb [arch=amd64,i386 signed-by=/usr/share/keyrings/winehq-archive.key] https://mirrors.tuna.tsinghua.edu.cn/wine-builds/ubuntu/ focal main' > /etc/apt/sources.list.d/winehq.list \
        && apt update -y \
        && apt install -y --install-recommends winehq-stable
       
RUN wget -O /usr/local/bin/winetricks https://ghproxy.com/https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
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
