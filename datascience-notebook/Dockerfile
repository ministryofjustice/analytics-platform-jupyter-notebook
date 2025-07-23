# lab-4.0.11
FROM quay.io/jupyter/datascience-notebook@sha256:76148e403aa44017f59b1dd0861d91daae800c7f86e9f39138b9d2703b885082

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
