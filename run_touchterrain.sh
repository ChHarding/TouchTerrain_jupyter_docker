#! /bin/bash

# runs jupyter on a local server

# Need to activate base conda env so that GDAL projection stuff works
source /usr/local/etc/profile.d/conda.sh # inits conda commands for bash
conda activate base
# show info on activated base env
conda info


cd /TouchTerrain/standalone
echo "Starting jupyter"
echo "You will see a URL starting with 127.0.0.1, something like http://127.0.0.1:8888/?token=ea78c44799a531743"
echo "Copy/paste that URL into your browser. If needed use the token (the stuff after token=) to log in."
jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root
