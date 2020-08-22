FROM ubuntu:20.04

ARG USER

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt-get update && \
      apt-get upgrade -y && \
      apt-get -y install \
        sudo \
        curl \
        neovim \
        tmux \
        git \
        build-essential \
        pkg-config \
        libssl-dev \
        zsh

RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G \
    sudo -m -s /bin/bash ${USER} && \
    echo ${USER}:${USER} | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh", "${USER}"]

