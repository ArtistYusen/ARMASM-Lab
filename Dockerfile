FROM ubuntu:20.04

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list & apt-get clean & apt-get update

RUN apt-get update && apt-get install -y wget git build-essential curl \
 && apt-get -y install python3.8 python3.8-dev python3-pip && apt-get -y install vim \
 && apt-get -y install gcc-arm-linux-gnueabi libc6-dev-armhf-cross qemu-user-static \
 && pip install numpy
COPY . /armasm_lab
WORKDIR /armasm_lab

CMD ["/bin/bash"]