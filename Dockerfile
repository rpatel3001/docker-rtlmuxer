FROM ghcr.io/sdr-enthusiasts/docker-baseimage:rtlsdr

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,SC2086,DL4006,SC2039
RUN set -x && \
    TEMP_PACKAGES=() && \
    KEPT_PACKAGES=() && \
    # packages needed to install
    TEMP_PACKAGES+=(git) && \
    # packages needed to build
    TEMP_PACKAGES+=(build-essential) && \
    # install packages
    apt-get update && \
    apt-get install -y --no-install-recommends \
        "${KEPT_PACKAGES[@]}" \
        "${TEMP_PACKAGES[@]}" && \
    # Deploy rtlmuxer
    git clone https://github.com/rpatel3001/rtlmuxer.git /src/rtlmuxer && \
    pushd /src/rtlmuxer && \
    make && \
    cp rtlmuxer /usr/local/bin && \
    popd && \
    # Clean up
    apt-get remove -y "${TEMP_PACKAGES[@]}" && \
    apt-get autoremove -y && \
    rm -rf /src/* /tmp/* /var/lib/apt/lists/*

COPY rootfs/ /

ENV SRC_ADDR="127.0.0.1" \
    SRC_PORT="1234" \
    SINK_ADDR="0.0.0.0" \
    RW_SINK_PORT="7373" \
    RO_SINK_PORT="7374" \
    GAIN="0" \
    FREQ="1545600550" \
    RATE="1536000" \
    SERIAL="00001542"
