#!/bin/bash 

# clones TouchTerrain from https://github.com/ChHarding/TouchTerrain_for_CAGEO
# Author: CH
# Date: Feb. 12, 2021

# clone or pull the repo, into the src folder
# check if the files have been cloned
if [ -d /TouchTerrain/standalone ]
  then
    echo "The TouchTerain repository already exists in standalone, use update_touchterrain.sh instead."
  else
    echo "Cloning repository"
    git clone https://github.com/ChHarding/TouchTerrain_for_CAGEO.git /TouchTerrain/standalone
fi

# Change the working directory to that of /TouchTerrain
echo "I am going to try to build and install touchterrain."
cd /TouchTerrain/standalone
pip install .

echo "touchterrain installed, you can now run jupyter via the run_touchterrain.sh script."
