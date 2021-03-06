# docker-nodejs-dev

> MagicVision nodejs development env based on Docker

[![Build Status](https://travis-ci.org/GetMagicVision/docker-nodejs-dev.svg)](https://travis-ci.org/GetMagicVision/docker-nodejs-dev)
[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/magicvision/nodejs-dev/)
[![Docker image layers and size](https://badge.imagelayers.io/magicvision/nodejs-dev:latest.svg)](https://imagelayers.io/?images=magicvision/nodejs-dev:latest 'Get your own badge on imagelayers.io')

## Features

- Docker 1.9.0 support with [docker:dind][]
- nvm 0.29.0
- node.js 5.0.0 with npm 3.3.6
- Ruby 1.9.1 with gem 1.8.23
- [Saas][] 3.4.18
- git 1.9.1
- python 2.7.6
- bower 1.6.5
- Run commands as a normal user named *ubuntu* with sudo permission
- Provisioning 114 DNS
- Tsinghua Ubuntu mirror
- Taobao nodejs and npm mirror

[docker:dind]: https://hub.docker.com/_/docker/#
[Saas]: https://github.com/sass/sass

## Getting Started

```bash
docker run --privileged --name docker-host -d docker:1.9-dind
docker run -it --link docker-host:docker magicvision/nodejs-dev /bin/bash
```

## License

MIT license
