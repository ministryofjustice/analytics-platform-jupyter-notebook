# lab-4.4.5
FROM quay.io/jupyter/datascience-notebook@sha256:c8a31a629cd58bc9d418df8057b41fa7f4e630edfbcb16f5adb2b0ed99271576

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Analytical Platform" \
      org.opencontainers.image.title="Jupyter Datascience Notebook" \
      maintainer="analytics-platform-tech@digital.justice.gov.uk"

ENV PATH="${PATH}:${HOME}/.local/bin" \
    CHOWN_HOME="no"

USER root

RUN apt-get update --yes \
    && apt-get install --yes \
         ca-certificates-java \
         openjdk-8-jdk \
         openssh-client \
         software-properties-common \
         gdal-bin \
         libspatialindex-dev \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir --upgrade \
         boto3 \
         black \
         nbstripout \
         rtree \
         s3fs==2023.12.2 \
         jupyterlab-git \
    && conda install --yes \
         nbstripout \
    && nbstripout --install --system \
    && update-alternatives --set editor /bin/nano-tiny

USER $NB_UID
