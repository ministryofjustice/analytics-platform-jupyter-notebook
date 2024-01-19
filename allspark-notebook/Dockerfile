# spark-3.5.0
FROM quay.io/jupyter/all-spark-notebook@sha256:a5bf7857fdfb439c21152f58f54b7c1fc795dfe47685b4969a0558e6a6295603

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
  nbstripout \
  "s3fs<=0.4" \
  dataengineeringutils3==1.3.0 \
  etl-manager==7.4.0

RUN conda install --yes \
    'nbstripout' 

RUN nbstripout --install --system
    
# Vi just doesn't cut it for some people
RUN update-alternatives --set editor /bin/nano-tiny
