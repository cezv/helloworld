# Project Notes

## About
Demo "Hello World" flask app, created on Debian 10 (Buster - DE Cinnamon), using Visual Studio Code.

## Current issues
None

## Cleared Issues (fixes or workarounds already applied)

**Virtual Machine constant crashes**
Memory problem caused in VBox apparently from a combination of using Cinnamon and VSCode. Here's the issue https://forums.virtualbox.org/viewtopic.php?t=79136. This was addressed in 2 ways: increasing the video memory in VBox and disabling hardware acceleration in VSCode.

**Corrupted requirements.txt file.**
Bumped into this bug https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1635463 which also affects Debian it became evident while building the container. The error is introduced after running pip freeze from a virtual environment. The workaround 
applied was removing the line from the requirements.txt

**Unable to start the gunicorn server due to missing module.**
This was just an observation error of the project tree structure caused by sudden drop in caffeine levels.

**Unable to connect to the web server.**
Attempting to get an HTTP response from the project failed with `curl: (7) Failed to connect to 127.0.0.1 port 5000: Connection refused`. Initial investigation lead to https://pythonspeed.com/articles/docker-connection-refused/, the Dockerfile definition was already exposing port 5000 but this lead to exposing all ports using the -P flag for troubleshooing purposes, which lead to a different curl error "curl: (7) Couldn't connect to server" which lead to a [StackOverflow](https://stackoverflow.com/questions/41083328/what-is-the-use-of-host-and-none-network-in-docker/43873743) answer that discussed the --network flag. A modification in the `ducker run` statement to include this flag and share the network stack resolved the problem: `docker run -it --rm --network=host helloflask` caused the curl to succeed with `< HTTP/1.1 200 OK`.

**Unable to connect to the Azure Container Registry.**
The command `az acr login --name <ACR>` failed with error:

>An error occurred: DOCKER_COMMAND_ERROR
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied

>Unable to get AAD authorization tokens with message: Please run 'az login' to setup account.
Unable to get admin user credentials with message: Please run 'az login' to setup account.

Executing with sudo lead to a different scenario, where credentials were required. However, the docker message hinted to a privilege problem.

[These instructions](https://docs.docker.com/engine/install/linux-postinstall/) were initially not followed to mitigate potential security problems but it was necessary to implement them for the azure cli to work properly.

**Kubernetes cluster fails to create.**
Running the `az aks create` command returned `Operation failed with status: 'Bad Request'.` followed with `Message: Operation could not be completed as it results in exceeding approved Total Regional Cores quota.` This error appeared when the `--node-count 2` statement was increased to 3 and it's due to an entitlement limitation with free accounts.

## Setting up

*Installing flask*
https://flask.palletsprojects.com/en/1.1.x/installation/

*Setup VSCode on Debian*
https://code.visualstudio.com/docs/setup/linux

*Installing Docker on Debian*
https://docs.docker.com/engine/install/debian/

*Purge docker images
https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

*Setup VSCode to work with Python virtual environments*
https://code.visualstudio.com/docs/python/environments

*Flask tutorial*
https://code.visualstudio.com/docs/python/tutorial-flask

*Markdown tips*
https://commonmark.org/

*Install Azure CLI with apt
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest

*Azure Kubernetes Service
https://docs.microsoft.com/en-us/azure/aks/

*Git cheatsheet
https://git.github.io/git-reference/remotes/
