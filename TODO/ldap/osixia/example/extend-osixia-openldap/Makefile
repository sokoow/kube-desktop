DOCKER_IMAGE_NAME =osixia/extend-osixia-openldap
VERSION = 0.1.0

.PHONY: all build build-nocache

all: build

build:
	docker build -t ${DOCKER_IMAGE_NAME} --rm .

build-nocache:
	docker build -t ${DOCKER_IMAGE_NAME} --no-cache --rm .
