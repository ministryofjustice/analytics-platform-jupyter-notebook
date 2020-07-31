SHELL = '/bin/bash'
export BUILD_TAG ?= latest
export DOCKER_BUILDKIT=1
export PROJECT_NAME=datascience-notebook

.PHONY: build test

build:
	docker build -t mojanalytics/${PROJECT_NAME}:${BUILD_TAG} .

test:
	docker-compose --project-name ${PROJECT_NAME} up -d
	docker-compose run --rm inspec exec tests -t docker://${PROJECT_NAME}_test_1

enter:
	docker-compose --project-name ${PROJECT_NAME} up -d
	docker-compose --project-name ${PROJECT_NAME} run --rm test bash

clean:
	docker-compose down
