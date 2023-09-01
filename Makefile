.DEFAULT_GOAL := build

FIRST_ARGS = $(word 2,$(MAKECMDGOALS))

.PHONY: help
help:                              ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

### Function for local installations
build:	## Build and up project for local installation
	docker build -t openconnect .

run:
	docker run --rm --privileged --name opc -d -p 4443:4443 -p 4443:4443/udp -v ${PWD}/config/:/config openconnect

down:
	docker stop opc

connect:
	docker exec -it opc /bin/sh

user:
	docker exec -ti opc ocpasswd -c /config/ocpasswd $(call FIRST_ARGS)

log:
	docker logs opc

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
