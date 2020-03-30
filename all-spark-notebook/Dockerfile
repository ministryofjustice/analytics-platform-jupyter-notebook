FROM jupyter/all-spark-notebook@sha256:1e31465c2dccb82ae249a31ba5412cf25388a12a9b949c76381842dd76b46efd

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
    && rm -rf  /var/lib/apt/lists/* \
    && pip install --upgrade nbstripout


RUN git clone -b jlab2 https://github.com/consideRatio/qgrid.git 

RUN jupyter labextension install qgrid/js/

RUN /opt/conda/bin/pip install qgrid/  




RUN chown -R $NB_UID /opt/conda \
    && usermod -u $NB_UID $NB_USER

