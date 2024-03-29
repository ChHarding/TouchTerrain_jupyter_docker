# Running TouchTerrain Standalone inside a Docker container
- This docker container has all the components installed needed to run [TouchTerrain](https://github.com/ChHarding/TouchTerrain_for_CAGEO) in stand alone mode (i.e. NOT via the web app) inside a jupyter notebook. Using standalone has many advantage compared to the web app.
- Once the the docker container is running, is can be used as a virtual Linux box. 
- Using docker ensures that all packages, including some tricky ones (looking at you GDAL!) are already installed in a modern Python system (currently 3.10).
- This will hopefully help us to bring the standalone version to more people, without as little complexity as possible. Although minimal, some command line (text terminal) activity is required.
- After creating the docker container, scripts are provided to install the latest version of TouchTerrain and to run a jupyter server inside the container. The server that can be accessed through your standard, local browser and you can download and upload files through jupyter.
- A new notebook (`TouchTerrain_jupyter_for_starters.ipynb`) will hopefully make is easy for beginners to work through the workflow of creating a 3D terrain model file in standalone.

### TouchTerrain Standalone Pros & Cons
#### Pros
- No server limitations regarding the size of the data that can be processed (other than your system specs). It is possible 
- Can process DEM data from a geotiff you provide (could be Lidar terrain!)
- Can digitize a polygon inside an interactive map (geemap)
- Integrates GPX line files to indicate path data on the terrain model
- Has an in-browser 3D model previewer (k3d)
- Uses the very flexible and resonably user-friendly jupyter notebook system to access the underlying Python code

#### Cons
- Some initial time investment required to set up docker
- Needs a somewhat beefy PC (8 Gb Ram minimum, 16 Gb recommended)
- Image is rather large: 2 Gb to download, extracts to 5Gb



## Instructions

### Installing Docker
- Download and install [Docker for Windows](https://www.docker.com/docker-windows) (Windows 10 Pro and up,[Windows Home](https://docs.docker.com/docker-for-windows/install-windows-home/)), [Docker for Mac](https://www.docker.com/docker-mac), or Docker for [Ubuntu](https://www.docker.com/docker-ubuntu) or [Debian](https://www.docker.com/docker-debian).
- Once docker is started, it will run in the background and also give you a GUI (Docker Desktop) in which you can configure some settings, such the the RAM of the container (3 GB is fine). However, most of the interaction will be done in the commandline (power shell in Win10)

### Running the container

(Note: I'm not using a data folder mounted as a volume on the container here b/c I find it easier to use jupyter's upload/download to transfer data to and fro the container.)

#### Download the image and run the container
- In Docker Desktop, delete any older container or image of touchterrain you might have.
- To get the image, go into a terminal on your "outside" OS (Terminal.app for MacOS, Powershell for Windows), while the docker app is running and type:
```console
docker pull chharding/touchterrain_jupyter
```
this will pull the already built image from dockerhub. The image is about 2 Gb to download but will require 5 Gb disk space. (You can do this in any folder, the image will be put into a special docker folder on your system, not the current folder.)

- To create a container running on your PC from this image, type:

```console
docker run -it -p 8888:8888 --name touchterrain_container chharding/touchterrain_jupyter
```

- `-it` means interactive, meaning your outside OS terminal will turn into a within-container (Linux) terminal
- `-p 8888:8888` sets the port through with your local browser will communicate with jupyter running in the container
- `--name touchterrain_container` sets the name of the container, otherwise its random.
- `chharding/touchterrain_jupyter` is the image you downloaded (pulled) earlier


- you will now be "inside" the container, i.e. what you type is actually run inside a virtual Linux box. You will see that your prompt has changed to root. Stay inside this shell and do __not__ open a new shell by clicking on the CLI button right to the container in the Docker Desktop app!
- before you can run jupyter and load your notebook, you have to install the touchterrain module. Run the `install_touchterrain.sh` shell script sitting in `/TouchTerrain`: (note the leading `./`. Hit tab after typing in `./in` to get a text completion to `./install_touchterrain.sh`)


```console
./install_touchterrain.sh
```

- This will clone the module from github and put it into `/TouchTerrain/standalone`. The standalone folder contains the notebook you will later run. STLs created via the notebook will also be in a subfolder in standalone, use jupyter's download functionality to copy them from the container to your OS.
- After the install script has created and filled the standalone folder, you cannot simple run it again.
- Instead, if you want to update touchterrain (b/c of some new development you want to use), you need to run `./update_touchterrain.sh` instead. 
- Update will copy newer files from github into the standalone folder, including the default notebooks! If you do not want to loose any work you have done with it,  be sure to rename it prior to the update!

#### Using the notebook
- To start a local jupyter server, run this shellscript (in `/TouchTerrain`)

```console
./run_touchterrain.sh
```

- You will see a URL starting with 127.0.0.1, something like `http://127.0.0.1:8888/?token=ea78c44799a531743`
- Copy/paste that URL into your browser. If needed, use the token (the stuff after token=) to log in.

- There are two notebooks:
  - `TouchTerrain_standalone_jupyter_notebook.ipynb`: This is the standard notebook and requires jupyter and Python knowledge
  - `TouchTerrain_jupyter_for_starters.ipynb`: __This notebook is recommended for beginners__. It is somewhat simplified and explains a lot of details that will hopefully be useful for those with little to no jupyter experience.
  - The other notebooks ending in binder and colab are not meant to be run in docker as the do some setup stuff needed for binder/colab.
- Note: Before you start you might want to make a copy of the original notebook and work on the copy instead.

- Click on the notebook (.ipynb file) to run it. 
- Read the instructions (ignore anything with install as you have everything already installed)
- You MUST run `ee.Authenticate()` at least once to access online DEM data or the interactive in-cell map `geemap`. You can ignore this if you only want to process raster DEM data. Look at EarthEngine_authentication_guide.md You will need a Google account to set up a EarthEngine project to generate a token that you can use to create a keyfile.  

- You can use `geemap` to digitize your printarea and  `k3d` to preview your STL (Dec. 8, 2022: this may not work anymore ...)
- If you want to stop the jupyter server, hit Control-c and then y. This will return you to the container terminal. Use `./run_touchterrain.sh` to start the server again.

#### Workflow tips
- Once you've created a terrain model, it will be inside the tmp folder as a zip file. To copy the zip to somewhere outside the container, look at the "file manager" (tree) that comes up initially when the jupyter server is started. Navigate to the tmp folder and select the zip file (checkboxes on the left). Several buttons will show up at the top, click Download to copy the zip file from the container to your "outside" OS for printing, etc. If you've used the 3D model previewer inside jupyter, you also have a folder from unzipping the zip file. You can remove this folder.
- If you want to copy a geotiff into the container to make a 3D terrain model from it, navigate to the folder the notebook (.ipynb) file is in and click on upload (upper right). Configure the `"importedDEM"` setting to point to this file. Same for using a bottom relief image.
- Note that any files you've created or changed inside the running container will still reside in the image after you've exited the container. However, if you want to go back and continue your work, you cannot simply use the docker run command from above again. Instead, go to the Docker Desktop app and find touchterrain_container under containers. To the right, find and click the CLI button to open a new container terminal. If CLI is greyed out, hit START first.

## How to build the image
- If you just want to pull the image from dockerhub and run it as a container on your PC, ignore this!
- This only applies if you want to build an image yourself, possible with a modified Dockerfile. Here I'm tagging the image so it belongs to my dockerhub id (chharding) and pushing it to doockerhub. You will either need to have you own dockerhub id or omit `-t chharding/touchterrain_jupyter:latest` to build a local image (and not push it!)

- Inside the project root folder, type:

```console
docker build -t chharding/touchterrain_jupyter:latest  .
docker push chharding/touchterrain_jupyter:latest
```

##### Thanks to Simon Marius Mudd (https://github.com/simon-m-mudd) for helping me build the docker image based on some of his examples!
