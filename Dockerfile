FROM gitlab/dind

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

# Use Taobao npm registry
RUN /root/.nvm/v4.1.0/bin/npm config set registry http://registry.npm.taobao.org

# Provisioning gitlab CA
ADD gitlab-CA.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
