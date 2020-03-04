## RISC-V Dockerfile (Development Branch)

This repository contains a **Dockerfile** of
[remz1337/docker-riscv](https://github.com/remz1337/docker-riscv)
for [Docker](https://www.docker.com/)'s
[Hub](https://registry.hub.docker.com/u/remz1337/docker-riscv) published 
to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Information

This container includes a number of tools and dependencies needed to
develop for the RISC-V open-source CPU. Many of these tools can be
located at 

https://github.com/riscv

and include an ISA simulator (Spike), a GCC toolchain for the RISC-V ISA.

### Getting Started

The best way to get started is to download the image for this
container directly from Doc Hub and then run the container and play
inside it. Here are the steps for that.

   1. Install docker on your client.
   2. docker pull remz1337/docker-riscv
   3. docker run -it remz1337/docker-riscv
   4. test the riscv compiler:
   ```
   riscv64-unknown-elf-gcc -o hello hello.c
   ```
   5. test the spike simulator:
   ```
   spike pk hello
   ```

### Notes

   1. Note this Dockerfile does not run through the automated build
   process because it exceeds the two hour build limit.
