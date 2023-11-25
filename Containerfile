ARG TARGETOS
ARG TARGETARCH

FROM --platform=$TARGETOS/$TARGETARCH itzg/minecraft-server:java20-alpine

LABEL author="HarvelsX" maintainer="xharvels@gmail.com"

ARG IMAGE_VERSION=1.0.0-SNAPSHOT
ARG GIT_REV

ENV TYPE=purpur
ENV VERSION=

ENV EULA=true

ADD plugins /plugins
ADD settings /config

ENV COPY_CONFIG_DEST=/data
ENV OVERRIDE_SERVER_PROPERTIES=false

ENV REMOVE_OLD_MODS=true
ENV REMOVE_OLD_DATAPACKS=true

ENV JVM_OPTS="-XX:+UseG1GC \
              -XX:+ParallelRefProcEnabled \
              -XX:MaxGCPauseMillis=200 \
              -XX:+UnlockExperimentalVMOptions \
              -XX:+DisableExplicitGC \
              -XX:+AlwaysPreTouch \
              -XX:G1NewSizePercent=30 \
              -XX:G1MaxNewSizePercent=40 \
              -XX:G1HeapRegionSize=8M \
              -XX:G1ReservePercent=20 \
              -XX:G1HeapWastePercent=5 \
              -XX:G1MixedGCCountTarget=4 \
              -XX:InitiatingHeapOccupancyPercent=15 \
              -XX:G1MixedGCLiveThresholdPercent=90 \
              -XX:G1RSetUpdatingPauseTimePercent=5 \
              -XX:SurvivorRatio=32 \
              -XX:+PerfDisableSharedMem \
              -XX:MaxTenuringThreshold=1 \
              -XX:+ExitOnOutOfMemoryError \
              -XX:+HeapDumpOnOutOfMemoryError"
ENV JVM_DD_OPTS="using.aikars.flags=https://mcflags.emc.gs, \
                 aikars.new.flags=true"
ENV USE_SIMD_FLAGS=true

ENV CFG_SERVER_TYPE="simple"
ENV CFG_HOSTNAME_FILE="/etc/hostname"
ENV CFG_IMAGE_VERSION=${IMAGE_VERSION:+"${IMAGE_VERSION}"}
ENV CFG_GIT_REV=${GIT_REV:+"-rev.${GIT_REV}"}