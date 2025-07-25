# lab-4.4.5
FROM quay.io/jupyter/all-spark-notebook@sha256:ce1206118af3e311d7770ae0a50f1d70445937c66867b7eacdac3d8a44ca6922

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Analytical Platform" \
      org.opencontainers.image.title="Jupyter All Spark Notebook" \
      maintainer="analytics-platform-tech@digital.justice.gov.uk"

ENV PATH="${PATH}:${HOME}/.local/bin" \
    CHOWN_HOME="no" \
    PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.12.134,org.apache.hadoop:hadoop-aws:3.0.1 pyspark-shell"

USER root

RUN apt-get update --yes \
    && apt-get install --yes \
         gdal-bin \
         libspatialindex-dev \
         openssh-client \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir --upgrade \
      pip \
      boto3 \
      nbstripout \
      s3fs==2023.12.2 \
      dataengineeringutils3==1.4.3 \
      etl-manager==7.6.0 \
    && conda install --yes \
         nbstripout \
    && nbstripout --install --system \
    && update-alternatives --set editor /bin/nano-tiny

USER $NB_UID
