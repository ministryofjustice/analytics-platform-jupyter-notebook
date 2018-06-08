# analytics-platform-jupyter-notebook
Jupyter Notebook Docker image for Analytics Platform

[Datascience-Notebook](https://quay.io/repository/mojanalytics/datascience-notebook)
[Allspark-Notebook](https://quay.io/repository/mojanalytics/all-spark)

### About Jupyter Notebook
From [Jupter](http://jupyter.org):
> The Jupyter Notebook is a web application that allows you to create and share documents that contain live code, equations,
> visualizations and explanatory text. Uses include: data cleaning and transformation, numerical simulation, statistical
> modeling, machine learning and much more."

## Docker image
These images are derived from [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks/blob/master/README.md).

**NOTE**: There is a page with recipes in the docker-stacks repository. This may be useful, [Jupyter Docker Recipes](https://github.com/jupyter/docker-stacks/wiki/Docker-Recipes)

### Build and Run
From the root of this repository
```
docker image build --no-cache -t jupyter/datascience-notebook -f datascience-notebook/Dockerfile .
```

__*Disabling authentication*__

In order to disable the authentication, we append `--NotebookApp.token=''` as an argument

```
docker container run -d --rm -p 8888:8888 jupyter/datascience-notebook start.sh jupyter lab --NotebookApp.token=''
```
 
### Known issues
 - This image is a work in progress, you'll currently get a "Dead kernel" error in Jupyter notebook ([this issue may be related](https://github.com/jupyter/docker-stacks/issues/337))
 - The image creates a 'jovyan' user with UID 1000, we'll need to figure it out how this will work with the NFS home (rename/change user UID?)
   - anaconda/jupyter dashboard are installed as this user, this may need to change
