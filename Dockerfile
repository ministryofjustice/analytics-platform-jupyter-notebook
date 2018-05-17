FROM jupyter/datascience-notebook:b7f28609e908

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin

ENV NB_UID=1001
