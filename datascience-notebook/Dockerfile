FROM jupyter/datascience-notebook:b7f28609e908

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin

ENV NB_UID=1001

COPY ./files/apt_packages /tmp/

RUN conda install boto3 \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages)
