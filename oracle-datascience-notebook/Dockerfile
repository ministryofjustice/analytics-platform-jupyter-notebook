FROM jupyter/datascience-notebook:76402a27fd13

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin \
  CHOWN_HOME=no \
  ORACLE_HOME=/opt/oracle/instantclient_19_6 \
  LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH \
  PATH=$PATH:$ORACLE_HOME \
  INSTANT_CLIENT_VERSION="19.6.0.0"

RUN apt-get update \
  && apt-get install -y \
  ca-certificates-java \
  openjdk-8-jdk \
  openssh-client \
  software-properties-common \
  gdal-bin \
  libspatialindex-dev \
  libaio1 \
  && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --set editor /bin/nano \
  && usermod -a -G "staff,users" "${NB_USER}"

# Install Oracle Instant Client and SQL*Plus
# See: https://www.oracle.com/uk/database/technologies/instant-client/linux-x86-64-downloads.html#ic_x64_inst
RUN mkdir /opt/oracle \
  && cd /opt/oracle \
  && curl -sO https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-basiclite-linux.x64-${INSTANT_CLIENT_VERSION}.0dbru.zip \
  && curl -sO https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-sqlplus-linux.x64-${INSTANT_CLIENT_VERSION}.0dbru.zip \
  && unzip instantclient-basiclite-linux.x64-${INSTANT_CLIENT_VERSION}.0dbru.zip \
  && unzip instantclient-sqlplus-linux.x64-${INSTANT_CLIENT_VERSION}.0dbru.zip \
  && rm instantclient-basiclite-linux.x64-${INSTANT_CLIENT_VERSION}.0dbru.zip instantclient-sqlplus-linux.x64-${INSTANT_CLIENT_VERSION}.0dbru.zip

RUN sh -c "echo /opt/oracle/instantclient_19_6 > /etc/ld.so.conf.d/oracle-instantclient.conf" \
  && ldconfig

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
