FROM jupyter/datascience-notebook:ad3574d3c5c7

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

COPY ./files/apt_packages /tmp/

RUN conda install boto3 black \
    && apt-get update \
    && apt-get install -y $(cat /tmp/apt_packages) \
    && rm -rf /var/lib/apt/lists/*

RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter 
RUN conda install -c conda-forge jupyterlab_code_formatter
RUN jupyter serverextension enable --py jupyterlab_code_formatter

# Fix conda install for NB_UID
RUN chown -R $NB_UID /opt/conda \
 &&usermod -u $NB_UID $NB_USER
