# Running touchterrain inside a Docker container

This docker container has all the components installed needed to run TouchTerrain in stand alone mode (i.e. NOT via the web app) inside a jupyter notebook

## Instructions

### Installing Docker
- Download and install [Docker for Windows](https://www.docker.com/docker-windows) (Windows 10 Pro and up,[Windows Home](https://docs.docker.com/docker-for-windows/install-windows-home/)), [Docker for Mac](https://www.docker.com/docker-mac), or Docker for [Ubuntu](https://www.docker.com/docker-ubuntu) or [Debian](https://www.docker.com/docker-debian).
- Once docker is started, it will run in the background but also give you a GUI (Docker Desktop) in which you can configure some settings, such the the RAM of the container (3 GB is fine). However, most of the interaction will be done in the commandline (power shell in Win10)

### Running the container
- Create a new directory/folder that will contain all files related to touchterrain, such as the github repo clone or your STL or geotiff files. For example: `C:\Users\chris\TouchTerrain` or `/Users/chris/TouchTerrain`

#### Download the image and run the container
- To get the image, go into a terminal (MacOS or Linux) or Powershell window (Windows) while docker is running and type:
```console
docker pull chharding/touchterrain_jupyter
```
- To create a container from the image type:

```console
docker run -it -v C:\Users\chris\TouchTerrain:/TouchTerrain -p 8888:8888 chharding/touchterrain_jupyter
```

- `-it` means interactive
- `-v`  links the files in the docker container with files in your host operating system.
- `-p 8888:8888` sets the port through with your local browser will communicate with jupyter running in the container
- `chharding/touchterrain_jupyter` is the image you downloaded (pulled) earlier


- you will now be "inside" the container, i.e. what you type is actually run inside a virtual Linux box. You will see that your prompt has changed to root. To exit the container and jump back to your native OS, type `exit`
- Any files/folders the Linux box has in /TouchTerrain will now be "mirrored" to C:\Users\chris\TouchTerrain, which enables you to access any STLs you create from within Windows or copy geotiffs from Windows to Linux.

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
- inside the project root folder, type:

```console
docker build -t chharding/touchterrain_jupyter:latest  .
```
