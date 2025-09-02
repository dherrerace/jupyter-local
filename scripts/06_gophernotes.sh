#!/usr/bin/env bash

dnf -y install go

go install github.com/gopherdata/gophernotes@v0.7.5
mkdir -p /opt/venv/local/share/jupyter/kernels/gophernotes
cd /opt/venv/local/share/jupyter/kernels/gophernotes
cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/*  "."
chmod +w ./kernel.json # in case copied kernel.json has no write permission
sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json