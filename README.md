# Local Jupyter

This is my set of scripts to start a containerized jupyter environment.

You just need [podman](https://podman.io) to run this.

## About the environment

It's a Fedora 38 container that installs the latest version
of jupyter available on pip. It also installs some useful utilities, like
simple spreadsheet support and colaboration tools.

Jupyter is started only with access to the jupyter_stuff folder, this folder's
permissions are changed during runtime so it's able to be accesed by the jupyter
containerized environment.

## local-jupyter.sh

This script starts a closed off jupyter server in a container, then it starts a
clean firefox instance wich can access that instance...

Did I mention that you need firefox to run this? woops sorry.

## shared-jupyter.sh

This starts the container exposed to your 8888 port. It will generate a link and
a random connection token on the terminal, so you can connect from there 
from any compatible browser.

You can use this if you want to host the instance to other computers or colaborate
with people you trust on your network.

## Troubleshooting

### I broke the thing and I want to access stuff but i can't...

Run this command, it basically runs as a root podman user in a rootless environment
to change the permissions of the folder to it's user to the root user in that context, 
which is the local user in your environment... 

If this is not a good enough explaination for you, you can check the 
[podman docs](https://docs.podman.io/en/latest/markdown/podman-unshare.1.html).

`podman unshare chown 0:0 -R ./jupyter_stuff`


