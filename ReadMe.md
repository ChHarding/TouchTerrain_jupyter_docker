# Running touchterrain inside a Docker container

This docker container has all the components installed needed to run [TouchTerrain](https://github.com/ChHarding/TouchTerrain_for_CAGEO) in stand alone mode (i.e. NOT via the web app) inside a jupyter notebook.

## Instructions

### Installing Docker
- Download and install [Docker for Windows](https://www.docker.com/docker-windows) (Windows 10 Pro and up,[Windows Home](https://docs.docker.com/docker-for-windows/install-windows-home/)), [Docker for Mac](https://www.docker.com/docker-mac), or Docker for [Ubuntu](https://www.docker.com/docker-ubuntu) or [Debian](https://www.docker.com/docker-debian).
- Once docker is started, it will run in the background but also give you a GUI (Docker Desktop) in which you can configure some settings, such the the RAM of the container (3 GB is fine). However, most of the interaction will be done in the commandline (power shell in Win10)

### Running the container

#### Creating a data folder
- Create a new directory/folder that will contain any data you want to transfer in and out of the container once it's running, such as STL files you've created or geotiff files you want to use with TouchTerrain. Example: `C:\Users\chris\TTdata` or `/Users/chris/TTdata`

#### Download the image and run the container
- To get the image, go into a terminal on your "outside" OS (Terminal.app for MacOS, Powershell for Windows), while the docker app is running and type:
```console
docker pull chharding/touchterrain_jupyter
```
this will pull the already built image from dockerhub.

- To create a container running on your PC from this image, type:

```console
docker run -it -v C:\Users\chris\TTdata:/TouchTerrain/TTdata -p 8888:8888 --name touchterain_container chharding/touchterrain_jupyter
```

- `-it` means interactive, meaning your outside OS terminal will turn into a within-container (Linux) terminal
- `-v`  left of colon is your data folder as see by your outside OS. right of the colon is how you will access it from inside the container.
- `-p 8888:8888` sets the port through with your local browser will communicate with jupyter running in the container
- `--name touchterain_container` sets the name of the container
- `chharding/touchterrain_jupyter` is the image you downloaded (pulled) earlier


- you will now be "inside" the container, i.e. what you type is actually run inside a virtual Linux box. You will see that your prompt has changed to root. To exit the container and jump back to your native OS, type `exit`
- Any files/folders the Linux box has in /TouchTerrain/TTdata will now be "mirrored" to C:\Users\chris\TTdata, which enables you to copy files between the container and your outside OS.
- before you can run jupyter and load your notebook, you have to install the touchterrain module. Run the `install_touchterrain.sh` shell script in `/TouchTerrain/standalone` (note the leading `./` !)


```console
./install_touchterrain.sh
```

- This will clone the module from github and put it into `/TouchTerrain/standalone`. standalone contains the notebook you will later run. STLs created via the notebook will also be in a subfolder in standalone.  
- After the install script has created and filled the standalone folder, you cannot simple run the it again. 
- Instead, if you want to update touchterrain (b/c of some new development you want to use), you need to run `./update_touchterrain.sh` instead. 
- Update will copy newer files from github into the standalone folder, including the default notebook called `TouchTerrain_standalone_jupyter_notebook.ipynb`! If you do not want to loose any work you have done with it,  be sure to rename it prior to the update!

#### Using the notebook
- To start a local jupyter server, run this shellscript (in `/TouchTerrain/standalone`)

```console
./run_touchterrain.sh
```

- You will see a URL starting with 127.0.0.1, something like `http://127.0.0.1:8888/?token=ea78c44799a531743`
- Copy/paste that URL into your browser. If needed, use the token (the stuff after token=) to log in.
- Note: you might want to make a copy of TouchTerrain_standalone_jupyter_notebook.ipynb and work on the copy instead.

- Click on the notebook (.ipynb file) to run it. 
- Read the instructions (ignore anything with install as you have everything already installed)
- You MUST run `ee.Autheticate()` at least once to access online DEM data or the interactive in-cell map `geemap`. You will need a Google account but once you've create the keyfile, you can comment `ee.Autheticate()` out again.

- You can use `geemap` to digitize your printarea and  `k3d` to preview your STL, no need to install them via pip



## How to build the image
- If you just want to pull the image from dockerhub and run is as a container on your PC, ignore this!
- This only applies if you want to build an image yourself, possible with a modified DOckerfile. Here I'm tagging the image so it belongs to my dockerhub id (chharding), but you will either need to have you own dockerhub id or omit `-t chharding/touchterrain_jupyter:latest` to build a local image.

- Inside the project root folder, type:

```console
docker build -t chharding/touchterrain_jupyter:latest  .
```

##### Thanks to Simaon Marius Mudd (https://github.com/simon-m-mudd) for helping me build the docker image based on some of his examples!
