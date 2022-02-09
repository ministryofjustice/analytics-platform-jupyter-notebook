FROM jupyter/datascience-notebook:lab-3.1.11

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

ENV PATH=$PATH:$HOME/.local/bin

# Home directory contents is already owned by UID 1000
ENV CHOWN_HOME=no

USER root

RUN apt-get update \
  && apt-get install -y \
  ca-certificates-java \
  openjdk-8-jdk \
  openssh-client \
  software-properties-common \
  gdal-bin \
  libspatialindex-dev \
  && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --set editor /bin/nano-tiny

RUN pip install --upgrade \
  boto3 \
  black \
  nbstripout \
  rtree \
  "s3fs<=0.4"

RUN conda install --yes \
    'nbstripout' 
