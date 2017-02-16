FROM jupyter/datascience-notebook

# Install Anaconda
RUN conda install anaconda

# Install Jupyter Dashboard
RUN pip install jupyter_dashboards
RUN jupyter dashboards quick-setup --sys-prefix
RUN jupyter nbextension enable jupyter_dashboards --py --sys-prefix

USER root
COPY container-start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/container-start.sh

EXPOSE 8888

CMD ["/usr/local/bin/container-start.sh"]
