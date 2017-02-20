FROM jupyter/datascience-notebook

# Install Anaconda
RUN conda install anaconda

# Install Jupyter Dashboard
RUN pip install jupyter_dashboards
RUN jupyter dashboards quick-setup --sys-prefix
RUN jupyter nbextension enable jupyter_dashboards --py --sys-prefix

USER root

# Changing ownership of $CONDA_DIR to all users in 'staff'
# (so we don't have to do it at container start)
RUN chown -R $NB_USER:staff $CONDA_DIR

COPY container-start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/container-start.sh

EXPOSE 8888

CMD ["/usr/local/bin/container-start.sh"]
