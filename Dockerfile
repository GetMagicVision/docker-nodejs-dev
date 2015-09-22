FROM ubuntu:14.04

MAINTAINER MagicVision Team

# Use Aliyun ubuntu mirror
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update -y

# Install nvm
RUN apt-get install -y curl build-essential libssl-dev && \
    curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh

# Use Taobao node mirror
ENV NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node

# Install node.js 4.1.0
RUN bash -ic "nvm install 4.1.0" && \
    bash -ic "nvm alias default 4.1.0" && \
    bash -ic "nvm use 4.1.0"
ENV PATH /root/.nvm/v4.1.0/bin/:$PATH

# Use Taobao npm registry
RUN /root/.nvm/v4.1.0/bin/npm config set registry http://registry.npm.taobao.org

# Provisioning gitlab CA
ADD gitlab-CA.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install docker-cli
# See https://github.com/docker-library/docker/blob/bb15fc25bbd4f51a880cf02f91eab447b1083b75/1.8/Dockerfile
# This image should start with `--link some-docker:docker`
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.8.2
ENV DOCKER_SHA256 97a3f5924b0b831a310efa8bf0a4c91956cd6387c4a8667d27e2b2dd3da67e4d
ENV DOCKER_HOST tcp://docker:2375
RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker && \
    echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - && \
    chmod +x /usr/local/bin/docker

# Install ruby and sass
RUN apt-get install -y ruby && gem install sass

# Install git
RUN apt-get install -y git

