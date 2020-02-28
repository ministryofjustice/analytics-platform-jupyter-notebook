FROM jupyter/datascience-notebook:14fdfbf9cfc1

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

COPY ./files/apt_packages /tmp/

RUN conda install boto3 black flake8 jupyterlab_code_formatter \
    && apt-get update \
    && apt-get install -y $(cat /tmp/apt_packages) \
    && rm -rf /var/lib/apt/lists/*

RUN npm install jupyterlab-flake8 \
    && jupyter labextension install jupyterlab-flake8 \
    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
    && jupyter serverextension enable --py jupyterlab_code_formatter \
    && pip install --upgrade nbstripout 

# Fix conda install for NB_UID
RUN chown -R $NB_UID /opt/conda \
 &&usermod -u $NB_UID $NB_USER
