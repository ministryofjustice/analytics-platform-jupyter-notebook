FROM jupyter/datascience-notebook:14fdfbf9cfc1

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

COPY ./files/apt_packages /tmp/

RUN conda install boto3 \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages)

# This installs a package that strips out notebooks before pushing to git (https://github.com/jond3k/ipynb_stripout)
RUN wget -O /usr/local/bin/ipynb_stripout "https://raw.githubusercontent.com/jond3k/ipynb_stripout/ae8c56091fce1ce525efd5cad8eb28c8760f9596/ipynb_stripout" \
    && chmod +x /usr/local/bin/ipynb_stripout

# Fix conda install for NB_UID
RUN chown -R $NB_UID /opt/conda
