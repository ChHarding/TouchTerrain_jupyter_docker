#!/bin/bash

# updates TouchTerrain from https://github.com/ChHarding/TouchTerrain_for_CAGEO
# Author: CH
# Date: Feb. 10, 2021

# This updates the repo and rebuilds the touchterrain module. If you have worked with a notebook
# called TouchTerrain_standalone_jupyter_notebook.ipynb, it will be overwritten by the update.
# You should have renamed your notebook but as a precaution, I've made a back up called
# TouchTerrain_standalone_jupyter_notebook.ipynb.old that you can use to rescue your
# notebook by renaming it to something like TouchTerrain_my_name.ipynb and running it
# after the update


echo "TouchTerrain_standalone_jupyter_notebook.ipynb has been renamed to TouchTerrain_standalone_jupyter_notebook.ipynb.old"

cp TouchTerrain_standalone_jupyter_notebook.ipynb TouchTerrain_standalone_jupyter_notebook.ipynb.old
git --work-tree=/TouchTerrain/standalone --git-dir=/TouchTerrain/standalone/.git pull origin master


echo "building and installing updated touchterrain module"
cd /TouchTerrain/standalone
pip install .

echo "Done! Use ./run_touchterrain.sh to start jupyter
