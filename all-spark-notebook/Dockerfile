FROM jupyter/all-spark-notebook@sha256:ae9cc8bfa83b41162369cd40fde65afa315ef7777f29c1e8bc8535d1396b621a

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

ENV PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.1 pyspark-shell"

COPY ./files/* /tmp/
RUN conda install boto3 \
    && python /tmp/pyspark-s3.py \
    && mv /tmp/hdfs-site.xml /usr/local/spark/conf \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages) \
    && rm -rf  /var/lib/apt/lists/*

RUN chown -R $NB_UID /opt/conda \
  && usermod -u $NB_UID $NB_USER
