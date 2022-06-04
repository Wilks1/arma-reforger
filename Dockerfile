FROM debian:bullseye-slim

LABEL maintainer="ACE Team - https://github.com/acemod"
LABEL org.opencontainers.image.source=https://github.com/acemod/docker-reforger

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
    && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        python3 \
        lib32stdc++6 \
        lib32gcc-s1 \
        wget \
        ca-certificates \
        libcurl4 \
        net-tools \
        libssl1.1 \
        wamerican \
    && \
    apt-get remove --purge -y \
    && \
    apt-get clean autoclean \
    && \
    apt-get autoremove -y \
    && \
    rm -rf /var/lib/apt/lists/* \
    && \
    mkdir -p /steamcmd \
    && \
    wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - -C /steamcmd

ENV TRACY_NO_INVARIANT_CHECK=1

ENV STEAM_USER=""
ENV STEAM_PASSWORD=""
ENV STEAM_BRANCH="public"
ENV STEAM_BRANCH_PASSWORD=""

ENV ARMA_CONFIG=docker_generated
ENV ARMA_PROFILE=/home/profile
ENV ARMA_BINARY="./ArmaReforgerServer"
ENV ARMA_PARAMS=""
ENV ARMA_MAX_FPS=120

ENV SERVER_REGION="US"
ENV SERVER_ID=""
ENV SERVER_ADMIN_PASSWORD="JTF2Test"
ENV SERVER_HOST_BIND_ADDRESS="0.0.0.0"
ENV SERVER_HOST_BIND_PORT=2001
ENV SERVER_HOST_REGISTER_ADDRESS="159.65.255.129"
ENV SERVER_HOST_REGISTER_PORT=2001

ENV GAME_NAME="JTF2 Public - Custom Operations - Game Master "
ENV GAME_PASSWORD=""
ENV GAME_SCENARIO_ID="{59AD59368755F41A}Missions/21_GM_Eden.conf"
ENV GAME_PLAYER_LIMIT=32
ENV GAME_AUTO_JOINABLE=false
ENV GAME_VISIBLE=true
ENV GAME_PROPS_BATTLEYE=true
ENV GAME_PROPS_DISABLE_THIRD_PERSON=true
ENV GAME_PROPS_FAST_VALIDATION=true
ENV GAME_PROPS_SERVER_MAX_VIEW_DISTANCE=2500
ENV GAME_PROPS_SERVER_MIN_GRASS_DISTANCE=50
ENV GAME_PROPS_NETWORK_VIEW_DISTANCE=1000

ENV SKIP_INSTALL=false

WORKDIR /reforger

VOLUME /steamcmd
VOLUME /home/profile
VOLUME /reforger/Configs

EXPOSE 2001/udp
EXPOSE 17777/udp

STOPSIGNAL SIGINT

COPY *.py /
COPY docker_default.json /

CMD ["python3","/launch.py"]
