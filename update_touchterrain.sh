#!/bin/bash

# updates TouchTerrain from https://github.com/ChHarding/TouchTerrain_for_CAGEO
# Author: CH
# Date: Feb. 5, 2021

# This updates the repo and rebuilds the touchterrain module. If you have worked with a notebook
# called TouchTerrain_standalone_jupyter_notebook.ipynb, it will be overwritten by the update.
# You should have renamed your notebook but as a precaution, I've made a back up called
# TouchTerrain_standalone_jupyter_notebook.ipynb.old that you can use to rescue your
# notebook by renaming it to something like TouchTerrain_my_name.ipynb and running it
# after the update

echo "The TouchTerain repository already exists in standalone, updating to the latest version."
echo "Making a copy of TouchTerrain_standalone_jupyter_notebook.ipynb to TouchTerrain_standalone_jupyter_notebook.ipynb.old"
echo "otherwise it would be overwritten with a newer version"
echo "If you had an older notebook called TouchTerrain_standalone_jupyter_notebook.ipynb that you worked on, it ois now called TouchTerrain_standalone_jupyter_notebook.ipynb.old"

cp TouchTerrain_standalone_jupyter_notebook.ipynb TouchTerrain_standalone_jupyter_notebook.ipynb.old
git --work-tree=/TouchTerrain/standalone --git-dir=/TouchTerrain/standalone/.git pull origin master


echo "building and installing updated touchterrain module"
cd /TouchTerrain/standalone
pip install .

