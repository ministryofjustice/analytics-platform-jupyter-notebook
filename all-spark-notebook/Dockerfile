FROM jupyter/all-spark-notebook:1145fb1198b2

LABEL maintainer=analytics-platform-tech@digital.justice.gov.uk

USER root

ENV PATH=$PATH:$HOME/.local/bin
ENV NB_UID=1001
ENV CHOWN_HOME=no

ENV PYSPARK_SUBMIT_ARGS="--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.1 pyspark-shell"

COPY ./files/* /tmp/
RUN conda install boto3 \
    && python /tmp/pyspark-s3.py \
    && pip install git+https://github.com/moj-analytical-services/etl_manager.git#egg=etl_manager \
    && pip install git+https://github.com/moj-analytical-services/dataengineeringutils.git \
    && pip install git+https://github.com/moj-analytical-services/gluejobutils/#egg=gluejobutils \
    && mv /tmp/hdfs-site.xml /usr/local/spark/conf \
    && apt-get update && apt-get install -y $(cat /tmp/apt_packages)

# This installs a package that strips out notebooks before pushing to git (https://github.com/jond3k/ipynb_stripout)
RUN wget -O /usr/local/bin/ipynb_stripout "https://raw.githubusercontent.com/jond3k/ipynb_stripout/ae8c56091fce1ce525efd5cad8eb28c8760f9596/ipynb_stripout" \
    && chmod +x /usr/local/bin/ipynb_stripout

RUN chown -R $NB_UID /opt/conda