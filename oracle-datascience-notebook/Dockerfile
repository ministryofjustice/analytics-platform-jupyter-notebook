FROM jupyter/datascience-notebook:76402a27fd13

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

RUN conda update conda \
    && conda install boto3 black flake8 jupyterlab_code_formatter \
    && apt-get update \
    && apt-get install -y \
    ca-certificates-java \
    openjdk-8-jdk \
    openssh-client \
    software-properties-common \
    gdal-bin \
    libspatialindex-dev \
    libaio1 \
    && rm -rf /var/lib/apt/lists/*

# Install Oracle Instant Client and SQL*Plus
# See: https://www.oracle.com/uk/database/technologies/instant-client/linux-x86-64-downloads.html#ic_x64_inst
RUN mkdir /opt/oracle \
    && cd /opt/oracle \
    && curl -sO https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip \
    && curl -sO https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-sqlplus-linux.x64-19.6.0.0.0dbru.zip \
    && unzip instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip \
    && unzip instantclient-sqlplus-linux.x64-19.6.0.0.0dbru.zip \
    && rm instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip instantclient-sqlplus-linux.x64-19.6.0.0.0dbru.zip

RUN sh -c "echo /opt/oracle/instantclient_19_6 > /etc/ld.so.conf.d/oracle-instantclient.conf" \
    && ldconfig

ENV ORACLE_HOME=/opt/oracle/instantclient_19_6
ENV LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
ENV PATH=$PATH:$ORACLE_HOME

RUN npm install jupyterlab-flake8 \
    && jupyter labextension install jupyterlab-flake8 \
    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
    && jupyter serverextension enable --py jupyterlab_code_formatter \
    && pip install --upgrade nbstripout

# Fix conda install for NB_UID
RUN chown -R $NB_UID /opt/conda \
    && usermod -u $NB_UID $NB_USER
