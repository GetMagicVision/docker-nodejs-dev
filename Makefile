SHELL = /bin/bash -o pipefail

test:
	docker build -t magicvision/nodejs-dev .
	docker run --rm magicvision/nodejs-dev bash -ic "node --version"
	docker run --rm magicvision/nodejs-dev ruby --version
	docker run --rm magicvision/nodejs-dev sass --version
	docker run --rm magicvision/nodejs-dev git --version
