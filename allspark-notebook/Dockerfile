FROM jupyter/all-spark-notebook:spark-3.1.1@sha256:b73dad39ad5c469a92764e38d7cc4321040d3fedddcad7fcebc4ddc7f9c15ff2

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

ENV PATH=$PATH:$HOME/.local/bin

# Home directory contents is already owned by UID 1000
ENV CHOWN_HOME=no

# NB these are sensible defaults but may need to be changed programatically for
# non local spark (ie. EMR etc.)
ENV PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.12.134,org.apache.hadoop:hadoop-aws:3.0.1 pyspark-shell"

# Container must be run as root to use NB_UID
USER root

# Install OS pacakges
#
# The reason we have installed these has been lost. Including just in case.
#
# - gdal-bin
# - libspatialindex-dev
# - openssh-client
#
RUN apt-get update && \
  apt-get install -y \
  gdal-bin \
  libspatialindex-dev \
  openssh-client && \
  rm -rf /var/lib/apt/lists/*

# I'm not sure this has any effect
COPY files/hdfs-site.xml /usr/local/spark/conf/hdfs-site.xml

# add-user-to-group.sh adds the $NB_USER to group 50 (staff) used by RStudio
COPY files/add-user-to-group.sh /usr/local/bin/before-notebook.d/

# Install python packages
# - pip - python package manager
# - boto3 - python AWS library
# - nbstripout - tool for stripping sensitive data out of notebooks
# 
RUN pip install --upgrade \
  pip \
  boto3 \
  s3fs<=0.4 \
  nbstripout \
  dataengineeringutils3==1.3.0 \
  etl-manager==7.4.0

# Vi just doesn't cut it for some people
RUN update-alternatives --set editor /bin/nano-tiny
