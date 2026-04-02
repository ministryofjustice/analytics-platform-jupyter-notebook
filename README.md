# analytics-platform-jupyter-notebook ........
JupyterLab Docker images for Analytical Platform.

CI/CD:

* CI: Github Actions [is configured](./.github/workflows/jupyter-lab-test-and-build.yml) to
   1. build these docker images
   1. run tests using [`inspec`](https://community.chef.io/tools/chef-inspec/)
   1. push image to AWS ECR
* Helm chart: <https://github.com/ministryofjustice/analytics-platform-helm-charts/tree/master/charts/jupyter-lab>
* Deployment: Done by Control Panel when a user deploys JupyterLab for

themselves. This releases the helm chart above.

## About Jupyter Notebook

From [Jupter](http://jupyter.org):

> The Jupyter Notebook is a web application that allows you to create and share documents that contain live code, equations,
> visualizations and explanatory text. Uses include: data cleaning and transformation, numerical simulation, statistical
> modeling, machine learning and much more."

## Docker images

We currently have 3 flavours of JupyterLab:

* `datascience-notebook` is the standard image currently used by most of our users
* `allspark-notebook` is similar to the `datascience-notebook` one but it
  includes Spark. This is currently used mainly by the Data Engineer team
  and it's [deployed manually](https://github.com/ministryofjustice/analytics-platform/wiki/Deploying-jupyterlab#spark-version).
  Long term we may use this image by default instead of the `datascience-notebook` one.
* `oracle-datascience-notebook` is a temporary image which contains drivers to
  connect to Oracle databases as part of some niche and temporary work.
  This image is hopefully going to disappear very soon.

These images are derived from [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks/blob/master/README.md).

**NOTE**: There is a page with recipes in the docker-stacks repository. This may be useful, [Jupyter Docker Recipes](https://github.com/jupyter/docker-stacks/wiki/Docker-Recipes)

### Build and Run

From the sub-directory for the image you want to build

``` bash
make build
```

### Releasing a new image version

Once your changes are approved and merged into the `main` branch, create a
new release tag from the GitHub interface.

This will trigger a new run of the GitHub Actions worflow which will build
the images and push to [our private AWS ECR registry](https://eu-west-1.console.aws.amazon.com/ecr/repositories?region=eu-west-1).

Once the image is correctly pushed to this registry you can update the relevant
[JupyterLab helm chart values](https://github.com/ministryofjustice/analytics-platform-helm-charts/blob/e2bc45e798ab97ee70a2f5a3cf52440648f23f81/charts/jupyter-lab/values.yaml#L31-L33) and/or update a specific user's
kubernetes `Deployment` .

If you're releasing a new version of the JupyterLab helm chart, talk with a
Control Panel admin to be sure this new version is added to the Tools catalogue
and users can deploy/upgrade JupyterLab and use it.

## Disabling authentication

In order to disable the authentication, we append `--NotebookApp.token=''` as an argument

``` bash
docker container run -d --rm -p 8888:8888 jupyter/datascience-notebook start.sh jupyter lab --NotebookApp.token=''
```

## Grant `sudo` with disabled authentication

``` bash
docker container run -d --rm -p 8888:8888 -e GRANT_SUDO=yes jupyter/datascience-notebook start.sh jupyter lab --NotebookApp.token=''
```

### Known issues

These images work, but with questions to resolve:

* The image creates a 'jovyan' user with UID 1000, we'll need to figure it
  out how this will work with the NFS home (rename/change user UID?)
* anaconda/jupyter dashboard are installed as this user, this may need to change

