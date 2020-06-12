# analytics-platform-jupyter-notebook

Jupyter Notebook Docker image for Analytics Platform

Contents:

- [Datascience-Notebook](https://quay.io/repository/mojanalytics/datascience-notebook) [![Docker Repository on Quay](https://quay.io/repository/mojanalytics/datascience-notebook/status "Docker Repository on Quay")](https://quay.io/repository/mojanalytics/datascience-notebook)
- [Oracle-Datascience-Notebook](https://quay.io/repository/mojanalytics/oracle-datascience-notebook) [![Docker Repository on Quay](https://quay.io/repository/mojanalytics/oracle-datascience-notebook/status "Docker Repository on Quay")](https://quay.io/repository/mojanalytics/oracle-datascience-notebook)
- [Allspark-Notebook](https://quay.io/repository/mojanalytics/all-spark) [![Docker Repository on Quay](https://quay.io/repository/mojanalytics/all-spark/status "Docker Repository on Quay")](https://quay.io/repository/mojanalytics/all-spark)

CI/CD:

- CI: Quay.io is configured to build each of these docker images - see links above.
- Helm chart: https://github.com/ministryofjustice/analytics-platform-helm-charts/tree/master/charts/jupyter-lab
- Deployment: Done by control panel when a user requests for themselves a Jupyter pod. Deploys using helm.

## About Jupyter Notebook

From [Jupter](http://jupyter.org):

> The Jupyter Notebook is a web application that allows you to create and share documents that contain live code, equations,
> visualizations and explanatory text. Uses include: data cleaning and transformation, numerical simulation, statistical
> modeling, machine learning and much more."

## Docker image

These images are derived from [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks/blob/master/README.md).

**NOTE**: There is a page with recipes in the docker-stacks repository. This may be useful, [Jupyter Docker Recipes](https://github.com/jupyter/docker-stacks/wiki/Docker-Recipes)

### Build and Run

From the root of this repository

```bash
docker image build --no-cache -t jupyter/datascience-notebook -f datascience-notebook/Dockerfile .
docker image build --no-cache -t jupyter/oracle-datascience-notebook -f oracle-datascience-notebook/Dockerfile .
docker image build --no-cache -t jupyter/all-spark -f all-spark-notebook/Dockerfile .
```

__*Disabling authentication*__

In order to disable the authentication, we append `--NotebookApp.token=''` as an argument

```bash
docker container run -d --rm -p 8888:8888 jupyter/datascience-notebook start.sh jupyter lab --NotebookApp.token=''
```

__*Grant `sudo` with disabled authentication*__

```bash
docker container run -d --rm -p 8888:8888 -e GRANT_SUDO=yes jupyter/datascience-notebook start.sh jupyter lab --NotebookApp.token=''
```

### Known issues

These images work, but with questions to resolve:

- The image creates a 'jovyan' user with UID 1000, we'll need to figure it out how this will work with the NFS home (rename/change user UID?)
  - anaconda/jupyter dashboard are installed as this user, this may need to change
