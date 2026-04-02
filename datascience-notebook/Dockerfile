# lab-4.4.5
FROM quay.io/jupyter/datascience-notebook@sha256:c8a31a629cd58bc9d418df8057b41fa7f4e630edfbcb16f5adb2b0ed99271576

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Analytical Platform" \
      org.opencontainers.image.title="Jupyter Datascience Notebook" \
      maintainer="analytics-platform-tech@digital.justice.gov.uk"

ENV PATH="${PATH}:${HOME}/.local/bin" \
    CHOWN_HOME="no"

USER root

# 1. Trust Zscaler corporate proxy certificate
COPY zscaler_certificate.crt /usr/local/share/ca-certificates/zscaler.crt
RUN chmod 644 /usr/local/share/ca-certificates/zscaler.crt && update-ca-certificates

# 2. Make sure all tools see the CA bundle
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# 3. System packages and Python/conda tooling
RUN apt-get update --yes \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes \
         ca-certificates-java \
         default-jre-headless \
         fonts-dejavu \
         g++ \
         git \
         htop \
         less \
         libgsl0-dev \
         libsm6 \
         libxext6 \
         libxrender1 \
         nano-tiny \
         netcat-openbsd \
         pandoc \
         python3-dev \
         software-properties-common \
         unzip \
         vim-tiny \
         libspatialindex-dev \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/*

# 4. Python/conda packages
RUN pip install --no-cache-dir --upgrade \
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