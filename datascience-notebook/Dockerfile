FROM jupyter/datascience-notebook:14fdfbf9cfc1

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

COPY ./files/apt_packages /tmp/

RUN conda install boto3 \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages)
