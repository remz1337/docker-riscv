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
FROM ubuntu:18.04

# Set the maintainer
#MAINTAINER Stephen Bates (sbates130272) <sbates@raithlin.com>

# Base recipe
# Install all dependencies
#
# sudo yum install -y autoconf automake python3 libmpc-devel mpfr-devel gmp-devel gawk  bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev
#
# Install toolchain
# git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
# mkdir opt/riscv
# export PATH="%PATH:/opt/riscv/bin"
# ./configure --prefix=/opt/riscv
# make
#
# Install RISCV tools (including simulator)
# git clone --recursive https://github.com/riscv/riscv-tools.git
# export RISCV=/opt/riscv/toolchain
# ./build.sh


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
ENV NUMJOBS 1
RUN mkdir -p $RISCV && mkdir -p $RISCVHOME

# Add the GNU utils bin folder to the path.
ENV PATH $RISCV/bin:$PATH

# Get and build the toolchain for RISCV.
WORKDIR $RISCVHOME/
RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain && cd riscv-gnu-toolchain && ./configure --prefix=$RISCV && make

# Get and build the RISC-V tools
WORKDIR $RISCVHOME/
RUN git clone --recursive https://github.com/riscv/riscv-tools.git && cd riscv-tools && ./build.sh

# Run a simple test to make sure at least spike, pk and the Newlib
# compiler are setup correctly.
RUN mkdir -p $RISCVHOME/test
WORKDIR $RISCVHOME/test
RUN echo '#include <stdio.h> int main(void) { printf("Hello world!"); return 0; }' > hello.c && riscv64-unknown-elf-gcc -o hello hello.c && spike pk hello

# Set the WORKDIR to be in the $RISCV folder and we are done!
WORKDIR $RISCV

# Now you can launch the container and run a command like:
#
# spike -m128 -p1 +disk=root.bin.sqsh bbl linux-4.1.y/vmlinux
#
