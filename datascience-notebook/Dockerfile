FROM jupyter/datascience-notebook:14fdfbf9cfc1

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

COPY ./files/apt_packages /tmp/

RUN conda install boto3 \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages)

RUN npm install -g topojson@^3.0.2
RUN jupyter labextension install @jupyterlab/geojson-extension
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.37
RUN jupyter labextension install jupyter-leaflet

# Fix conda install for NB_UID
RUN chown -R $NB_UID /opt/conda
