# build image for jupyter, includes all needed modules (even gdal, geemap and k3d)
# except touchterrain which will need to be pip installed from github via a shell script 
# Based on docker files by Simon Mudd (simon.m.mudd@ed.ac.uk)
# Pull base image. We start from the miniconda image
FROM conda/miniconda3
LABEL maintainer="charding@iastate.edu"

# Need this to shortcut the stupid tzdata noninteractive thing
ARG DEBIAN_FRONTEND=noninteractive

# Update conda
RUN conda install -y -c conda-forge conda

# Add the conda forge
RUN conda config --add channels conda-forge

# Set the channel
RUN conda config --set channel_priority strict

# Some tools for fetching data
RUN conda install -y wget unzip

# More c++ tools
RUN conda install -y boost-cpp

# Add git so you can clone the touchterrain repo
RUN conda install -y git python=3

# Now an environment for building conda
RUN conda install -y conda-build

# Now add some conda packages (same as in setup.py)
RUN conda install -y Pillow         
RUN conda install -y earthengine-api
RUN conda install -y Flask
RUN conda install -y oauth2client
RUN conda install -y kml2geojson
RUN conda install -y geojson
RUN conda install -y defusedxml
RUN conda install -y six
RUN conda install -y numpy
RUN conda install -y gdal	
RUN conda install -y k3d

# install geemap
RUN conda install mamba -y -c conda-forge
RUN mamba install geemap -y -c conda-forge
RUN mamba install jupyter_contrib_nbextensions -y -c conda-forge

# Here you can put some missing packages
RUN apt-get update && apt-get install -y \
    build-essential \
    vim \
&& rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /TouchTerrain

# open port 8888
EXPOSE 8888

# Make scripts ecexutable
COPY install_touchterrain.sh /TouchTerrain
RUN chmod +x install_touchterrain.sh
COPY update_touchterrain.sh /TouchTerrain
RUN chmod +x update_touchterrain.sh
COPY run_touchterrain.sh /TouchTerrain
RUN chmod +x run_touchterrain.sh

