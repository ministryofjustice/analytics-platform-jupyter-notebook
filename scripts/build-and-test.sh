#!/usr/bin/env bash

 IMAGE="${1}"
 IMAGE_TAG="analytical-platform.service.justice.gov.uk/${IMAGE}:local"
 CONTAINER_STRUCTURE_TEST_IMAGE="gcr.io/gcp-runtimes/container-structure-test:latest"

 echo "Building [ ${IMAGE} ] as [ ${IMAGE_TAG} ]"

 docker build --file "${IMAGE}/Dockerfile" --tag "${IMAGE_TAG}" "${IMAGE}"

 if [[ -f "${IMAGE}/test/container-structure-test.yml" ]]; then
   echo "Running container structure test for [ ${IMAGE_TAG} ]"

   docker run --rm \
     --volume /var/run/docker.sock:/var/run/docker.sock \
     --volume "${PWD}:/workspace" \
     --workdir /workspace \
     "${CONTAINER_STRUCTURE_TEST_IMAGE}" \
     test --image "${IMAGE_TAG}" --config "/workspace/${IMAGE}/test/container-structure-test.yml"
 fi
