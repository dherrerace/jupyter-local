#!/usr/bin/env bash

set -e

./prepare.sh

mkdir -p jupyter_stuff/.local/share/jupyter/runtime

podman unshare chown $UID:$UID -R $(pwd)/jupyter_stuff

(podman run -ti --rm \
    --name=jupyter-local \
    --user $UID \
    -v $(pwd)/jupyter_stuff:/jupyter_stuff:Z \
    --workdir=/jupyter_stuff \
    -p=8888:8888 \
    localhost/jupyter-local-image:latest \
    /opt/venv/bin/jupyverse \
        --host 0.0.0.0 \
        --port 8888 \
        --set frontend.collaborative=true \
        --set auth.mode=token \
) && true

ERR=$?

podman unshare chown 0:0 -R $(pwd)/jupyter_stuff

exit $ERR