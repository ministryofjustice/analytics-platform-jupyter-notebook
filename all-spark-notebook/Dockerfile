FROM jupyter/all-spark-notebook:1145fb1198b2

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin

ENV PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.1 pyspark-shell"

COPY ./files/* /tmp/
RUN conda install boto3 \
    && python /tmp/pyspark-s3.py \
    && pip install git+https://github.com/moj-analytical-services/etl_manager.git#egg=etl_manager \
    && pip install git+https://github.com/moj-analytical-services/dataengineeringutils.git \
    && pip install git+https://github.com/moj-analytical-services/gluejobutils/#egg=gluejobutils \
    && mv /tmp/hdfs-site.xml /usr/local/spark/conf \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages)
