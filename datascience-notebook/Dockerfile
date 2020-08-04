FROM jupyter/datascience-notebook:229c7fea9d60
USER root
ENV NB_UID="1001"

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
        && usermod -u "${NB_UID}" "${NB_USER}" \
        && usermod -a -G "staff,users" "${NB_USER}"
RUN chown -R ${NB_UID} /opt/conda

USER $NB_USER
RUN pip install --upgrade \
        boto3 \
        black \
        flake8 \
        jupyterlab_code_formatter \
        nbstripout \
        rtree \
        s3fs

RUN npm install jupyterlab-flake8

ENV JUPYTERLAB_DIR="/home/jovyan/.jupyter"
RUN jupyter labextension install \
        jupyterlab-flake8 \
        @jupyter-widgets/jupyterlab-manager \
        @jupyterlab/github \
        @jupyterlab/git \
        @ryantam626/jupyterlab_code_formatter
RUN jupyter serverextension enable --py \
        jupyterlab_code_formatter
