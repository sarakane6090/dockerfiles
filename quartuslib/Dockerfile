FROM ubuntu:18.04

LABEL maintainer "sarakane6090 <sarakane6090@gmail.com>"

ENV DEBCONF_NOWARNINGS noninteractive

COPY build_freetype.sh /tmp
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Environment Variables for Quartus Prime and ModelSim
ARG QUARTUS_VER="18.1"
ENV QSYS_ROOTDIR="/eda/intelFPGA_lite/$QUARTUS_VER/quartus/sopc_builder/bin"
ENV PATH=$PATH:/eda/intelFPGA_lite/$QUARTUS_VER/quartus/bin
ENV PATH=$PATH:/eda/intelFPGA_lite/$QUARTUS_VER/modelsim_ase/linuxaloem
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib32

RUN set -eux && \
    sed -i -e '$a deb http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse' /etc/apt/sources.list && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --no-install-recommends -qq -y \
        software-properties-common \
        build-essential \
        g++-multilib \
        gcc-multilib \
        gosu \
        && \
    # Install libraries required for Quartus Prime
    apt-get install --no-install-recommends -qq -y \
        libfontconfig1:amd64 \
        libglib2.0-0:amd64 \
        libpng12-0:amd64 \
        libsm6:amd64 \
        libxext6:amd64 \
        libxrender1:amd64 \
        locales \
        && \
    locale-gen en_US.UTF-8 && \
    # Install librarise required for Platform Designer(Qsys)
    apt-get install --no-install-recommends -qq -y \
        openjdk-8-jre \
        && \
    # Install libraries required for ModelSim
    apt-get install --no-install-recommends -qq -y \
        libncurses5:i386 \
        libxext6:i386 \
        libxft2:i386 \
        wget \
        && \
    chmod +x /tmp/build_freetype.sh && \
    /tmp/build_freetype.sh && \
    # Clean up
    rm -rf /tmp/* && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    # Set entry point
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash", "-l"]
