FROM jupyter/datascience-notebook

# Install Anaconda
RUN conda install anaconda

# Install Jupyter Dashboard
RUN pip install jupyter_dashboards
RUN jupyter dashboards quick-setup --sys-prefix
RUN jupyter nbextension enable jupyter_dashboards --py --sys-prefix

COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 8888

USER root

CMD ["/usr/local/bin/start.sh"]
