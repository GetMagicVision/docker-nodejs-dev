SHELL = /bin/bash -o pipefail

test:
	docker build -t magicvision/nodejs-dev .
	docker run --rm magicvision/nodejs-dev node --version
	docker run --rm magicvision/nodejs-dev npm --version
	docker run --rm magicvision/nodejs-dev ruby --version
	docker run --rm magicvision/nodejs-dev sass --version
	docker run --rm magicvision/nodejs-dev git --version
	docker run --rm magicvision/nodejs-dev python --version
	docker run --rm magicvision/nodejs-dev bower --version
