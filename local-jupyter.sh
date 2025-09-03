#!/usr/bin/env bash

set -e

./prepare.sh

mkdir -p jupyter_stuff/.local/share/jupyter/runtime

podman unshare chown $UID:$UID -R $(pwd)/jupyter_stuff

podman run -d --rm \
    --name=jupyter-local \
    --user $UID \
    --network=bridge \
    -v $(pwd)/jupyter_stuff:/jupyter_stuff:Z \
    --workdir=/jupyter_stuff \
    localhost/jupyter-local-image:latest \
    /opt/venv/bin/jupyverse \
        --host 0.0.0.0 \
        --port 8888 \
        --set frontend.collaborative=true \
        --set auth.mode=noauth
podman logs -f --color jupyter-local &

# Run firefox inside container network
CONTAINER_IP=$(podman inspect jupyter-local -f '{{ .NetworkSettings.IPAddress }}')

mkdir -p ./firefox_profile
(podman unshare --rootless-netns \
    firefox \
        -P "Jupyter-Profile" \
        --profile ./firefox_profile \
        --private-window http://${CONTAINER_IP}:8888/lab) && true
ERR=$?

podman stop jupyter-local

podman unshare chown 0:0 -R $(pwd)/jupyter_stuff

exit $ERR