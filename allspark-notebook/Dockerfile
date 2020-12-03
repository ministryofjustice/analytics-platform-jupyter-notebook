FROM jupyter/all-spark-notebook:1145fb1198b2

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no
ENV PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.1 pyspark-shell"

RUN update-alternatives --set editor /bin/nano \
    && usermod -a -G "staff,users" "${NB_USER}"

COPY ./files/* /tmp/

RUN python /tmp/pyspark-s3.py \
    && pip install --upgrade nbstripout boto3 pip\
    && pip install etl-manager==7.3.0 \
    && pip install gluejobutils==3.1.1 \
    && mv /tmp/hdfs-site.xml /usr/local/spark/conf \
    && apt-get update && apt-get install -y \
    ca-certificates-java \
    openjdk-8-jdk \
    openssh-client \
    software-properties-common \
    gdal-bin \
    libspatialindex-dev \
    && rm -rf  /var/lib/apt/lists/*

RUN chown -R "${NB_UID}" /opt/conda \
    && usermod -u "${NB_UID}" "${NB_USER}"

RUN usermod -a -G "staff,users" "${NB_USER}" \
    && update-alternatives --set editor /bin/nano
