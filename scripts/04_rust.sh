#!/usr/bin/env bash

set -e

dnf -y install rust rust-src cargo

cargo install --locked evcxr_jupyter

env JUPYTER_PATH=/usr/local/share/jupyter/ /root/.cargo/bin/evcxr_jupyter --install