SHELL = '/bin/bash'
export BUILD_TAG ?= latest
export DOCKER_BUILDKIT=1
export PROJECT_NAME=datascience-notebook

.PHONY: build test

build:
	docker build -t 593291632749.dkr.ecr.eu-west-1.amazonaws.com/${PROJECT_NAME}:${BUILD_TAG} .

test:
	docker-compose --project-name ${PROJECT_NAME} up -d test
	docker-compose run --rm inspec exec tests -t docker://${PROJECT_NAME}_test_1
	docker-compose stop

enter:
	docker-compose --project-name ${PROJECT_NAME} run --rm test bash

clean:
	docker-compose --project-name ${PROJECT_NAME} down
