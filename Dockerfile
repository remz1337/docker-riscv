#
# RISC-V Dockerfile
#
# https://github.com/remz1337/docker-riscv
# forked from
# https://github.com/sbates130272/docker-riscv
#
# This Dockerfile creates a container full of lots of useful tools for
# RISC-V development. See associated README.md for more
# information. This Dockerfile is mostly based on the instructions
# found at https://github.com/riscv/riscv-tools.

# Pull base image
FROM ubuntu:18.04 AS base

# Set the maintainer
MAINTAINER Rémi Bédard-Couture (remz1337) <remi.bc@inforem.ca>

# Install some base tools that we will need to get the risc-v toolchain working.
RUN apt-get update -y && apt-get install -y --fix-missing \
 autoconf \
 automake \
 autotools-dev \
 bc \
 bison \
 build-essential \
 curl \
 device-tree-compiler \
 flex \
 gawk \
 git \
 gperf \
 libexpat-dev \
 libmpc-dev \
 libmpfr-dev \
 libgmp-dev \
 libtool \
 libusb-1.0-0-dev \ 
 texinfo \ 
 patchutils \
 pkg-config \
 python3 \
 zlib1g-dev

# Make a working folder and set the necessary environment variables.
ENV RISCV /opt/riscv
ENV RISCVHOME /home/riscv
RUN mkdir -p $RISCV && mkdir -p $RISCVHOME

# Add the GNU utils bin folder to the path.
ENV PATH $RISCV/bin:$PATH

######### CC_toolchain
# Get and build the toolchain for RISCV.
#WORKDIR $RISCVHOME/
#RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain && cd riscv-gnu-toolchain && ./configure --prefix=$RISCV && make

######### CC_tools
# Get and build the RISC-V tools
#WORKDIR $RISCVHOME/
#RUN git clone --recursive https://github.com/riscv/riscv-tools.git && cd riscv-tools && ./build.sh

# Set the WORKDIR to be in the $RISCV folder and we are done!
#WORKDIR $RISCV
