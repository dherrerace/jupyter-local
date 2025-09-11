#!/usr/bin/env bash

dnf -y install go

GOBIN=/usr/local/bin go install github.com/gopherdata/gophernotes@v0.7.5
mkdir -p /opt/venv/share/jupyter/kernels/gophernotes
cd /opt/venv/share/jupyter/kernels/gophernotes
cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/*  "."
chmod +w ./kernel.json # in case copied kernel.json has no write permission
sed "s|gophernotes|/usr/local/bin/gophernotes|" < kernel.json.in > kernel.json