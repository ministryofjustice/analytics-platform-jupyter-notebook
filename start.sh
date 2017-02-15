#!/usr/bin/env bash

NB_USER=$USER
NB_UUID=$USER_UID
USER_UID=1001
GROUP=staff

# Add the $USER user
useradd -g $GROUP -u $USER_UID -d /home/$USER $USER

# Copy jovyan's files in the home without overwriting (-n)
cp -nR /home/jovyan/* /home/$USER/
chown -R $USER /home/$USER
chown -R $USER /opt/conda

sudo su - $USER

# Disable authentication, see: https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/README.md#notebook-options
start-notebook.sh --NotebookApp.token=''
