#!/usr/bin/env bash

set -e

dnf -y install rust rust-src cargo

cargo install --root /usr/local --locked evcxr_jupyter

env JUPYTER_PATH=/opt/venv/share/jupyter/ /usr/local/bin/evcxr_jupyter --install