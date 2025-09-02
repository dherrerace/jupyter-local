#!/usr/bin/env bash

dnf -y install \
        nodejs \
        npm

npm install -g tslab
tslab install --python=/opt/venv/bin/python