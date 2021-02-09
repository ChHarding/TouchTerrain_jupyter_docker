# runs jupyter  on a local server


cd /TouchTerrain/standalone
echo "Starting jupyter"
echo "You will see a URL starting with 127.0.0.1, something like http://127.0.0.1:8888/?token=ea78c44799a531743"
echo "Copy/paste that URL into your browser. If needed use the token (the stuff after token=) to log in."
echo "Note: you might want to make a copy of TouchTerrain_standalone_jupyter_notebook.ipynb and work on the copy instead"
jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root