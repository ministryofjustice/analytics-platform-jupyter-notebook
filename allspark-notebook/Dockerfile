FROM jupyter/all-spark-notebook:1145fb1198b2

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

ENV PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.1 pyspark-shell"

COPY ./files/* /tmp/
RUN conda install boto3 \
    && python /tmp/pyspark-s3.py \
    && pip install git+https://github.com/moj-analytical-services/etl_manager.git#egg=etl_manager \
    && pip install git+https://github.com/moj-analytical-services/dataengineeringutils.git \
    && pip install git+https://github.com/moj-analytical-services/gluejobutils/#egg=gluejobutils \
    && pip install --upgrade nbstripout \
    && mv /tmp/hdfs-site.xml /usr/local/spark/conf \
    && apt-get update && apt-get install -y \
    ca-certificates-java \
    openjdk-8-jdk \
    openssh-client \
    software-properties-common \
    gdal-bin \
    libspatialindex-dev \
    && rm -rf  /var/lib/apt/lists/*

RUN chown -R $NB_UID /opt/conda \
    && usermod -u $NB_UID $NB_USER

# Set nano as default editor
RUN update-alternatives --set editor /bin/nano