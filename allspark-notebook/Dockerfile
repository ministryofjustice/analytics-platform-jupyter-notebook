FROM jupyter/all-spark-notebook:399cbb986c6b
LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin \
  CHOWN_HOME=no \
  PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.11.918,org.apache.hadoop:hadoop-aws:3.0.1 pyspark-shell"
# `org.apache.hadoop:hadoop-aws` version must match `pyspark` version

RUN apt-get update && apt-get install -y \
  ca-certificates-java \
  openjdk-8-jdk \
  openssh-client \
  software-properties-common \
  gdal-bin \
  libspatialindex-dev \
  && rm -rf /var/lib/apt/lists/*

COPY files/pyspark-s3.py /tmp/pyspark-s3.py
COPY files/hdfs-site.xml /usr/local/spark/conf/hdfs-site.xml

RUN usermod -a -G "staff,users" "${NB_USER}" \
  && update-alternatives --set editor /bin/nano-tiny

USER $NB_USER
RUN pip install --upgrade \
  pip \
  boto3 \
  pyspark==3.0.1 \
  nbstripout \
  etl-manager==7.3.0 \
  gluejobutils==3.1.1
