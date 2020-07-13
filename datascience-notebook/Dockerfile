FROM jupyter/datascience-notebook:229c7fea9d60

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

USER $NB_USER
RUN pip install --upgrade \
        boto3 \
        black \
        flake8 \
        jupyterlab_code_formatter \
        nbstripout \
        rtree

RUN npm install jupyterlab-flake8
RUN jupyter labextension install jupyterlab-flake8 \
        && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
        && jupyter serverextension enable --py jupyterlab_code_formatter
