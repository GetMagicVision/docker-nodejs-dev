FROM ubuntu:14.04

MAINTAINER MagicVision Team

ENV NVM_VERSION v0.29.0
ENV NODEJS_VERSION v5.0.0
ENV DOCKER_VERSION 1.9.0

RUN apt-get update -y

# Add a normal user with sudo permission
RUN adduser --disabled-password --gecos "" ubuntu && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu

# Install nvm
RUN apt-get install -y curl build-essential libssl-dev man && \
    curl https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | su - ubuntu -c sh && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> /etc/profile && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> /etc/profile

# Install node.js
RUN su - ubuntu -c "nvm install $NODEJS_VERSION" && \
    su - ubuntu -c "nvm alias default $NODEJS_VERSION" && \
    su - ubuntu -c "nvm use $NODEJS_VERSION"

# Use Taobao node mirror and npm registry
ENV NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
RUN su - ubuntu -c "npm config set registry http://registry.npm.taobao.org"

# Provisioning gitlab CA
ADD gitlab-CA.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install docker-cli
# See https://github.com/docker/docker/releases
ENV DOCKER_BUCKET get.docker.com
RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker

# Install ruby and sass
RUN apt-get install -y ruby && gem install sass

# Install git
RUN apt-get install -y git

# Install python
RUN apt-get install -y python

# Install bower
RUN apt-get install -y libkrb5-dev && su - ubuntu -c "npm install -g bower"

# Use tsinghua ubuntu mirror
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update -y

# Use 114 DNS
RUN echo "nameserver 114.114.114.114" > /etc/resolv.conf

# Create builds dir for CI
RUN mkdir /builds && chmod 777 /builds

COPY ./entrypoint.sh /
RUN chmod 755 /entrypoint.sh

# Run as a normal user
USER ubuntu
WORKDIR /home/ubuntu
ENTRYPOINT ["/entrypoint.sh"]
