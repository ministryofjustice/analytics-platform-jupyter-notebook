FROM jupyter/datascience-notebook:lab-3.1.11
LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

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

RUN update-alternatives --set editor /bin/nano \
  && usermod -a -G "staff,users" "${NB_USER}"

USER $NB_USER
RUN pip install --upgrade \
  boto3 \
  black \
  nbstripout \
  rtree \
  s3fs

ENV JUPYTERLAB_DIR="/home/jovyan/.jupyter"
RUN jupyter labextension install \
  @jupyter-widgets/jupyterlab-manager \
  @jupyterlab/github \
  @jupyterlab/git

RUN pip install flake8 \
  && jupyter labextension install jupyterlab-flake8

RUN pip install jupyterlab_code_formatter==1.3.8 \
  && jupyter labextension install @ryantam626/jupyterlab_code_formatter@v1.3.8 \
  && jupyter serverextension enable --user --py jupyterlab_code_formatter
