########################################
#        SWC-TERRAFORM MAKEFILE        #
#       Author: Aurelien PERRIER       #
########################################

CONTAINER=needpc/scw-terraform:latest

all: build exec

build:
	@echo "Build Docker image ..."
	docker build . -t $(CONTAINER)

exec:
	@echo "Run Docker container ..."
	docker run -it --rm -v $(shell pwd):/data $(CONTAINER) ${ARG}

clean:
	@echo "Remove Docker image ..."
	docker rmi ${CONTAINER} -f

.PHONY: help build exec clean