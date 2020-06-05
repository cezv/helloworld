# Project Notes

## About
Created on Debian 10 (Buster - DE Cinnamon), using Visual Studio Code.

## Current issues


## Cleared Issues (fixes or workarounds already applied)

Memory problem caused in VBox apparently from a combination of using Cinnamon and VSCode. Here's the issue https://forums.virtualbox.org/viewtopic.php?t=79136. This was addressed in 2 ways: increasing the video memory in VBox and disabling hardware acceleration in VSCode.

Bumped into this bug https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1635463 which also affects Debian it became evident while building the container. The error is introduced after running pip freeze from a virtual environment. The workaround 
applied was removing the line from the requirements.txt

Unable to start the gunicorn server due to missing module. This was just an observation error of the project tree structure caused by sudden drop in caffeine levels.

Unable to connect to the web server. Attempting to get an HTTP response from the project failed with "curl: (7) Failed to connect to 127.0.0.1 port 5000: Connection refused". Initial investigation lead to https://pythonspeed.com/articles/docker-connection-refused/, the Dockerfile definition was already exposing port 5000 but this lead to exposing all ports using the -P flag for troubleshooing purposes, which lead to a different curl error "curl: (7) Couldn't connect to server" which lead to a [StackOverflow](https://stackoverflow.com/questions/41083328/what-is-the-use-of-host-and-none-network-in-docker/43873743) answer that discussed the --network flag. A modification in the `ducker run` statement to include this flag and share the network stack resolved the problem: `docker run -itP --rm --network=host helloflask` caused the curl to succeed with `< HTTP/1.1 200 OK`.

## Setting up

*Installing flask*
https://flask.palletsprojects.com/en/1.1.x/installation/

*Setup VSCode on Debian*
https://code.visualstudio.com/docs/setup/linux

*Installing Docker on Debian*
https://docs.docker.com/engine/install/debian/

*Setup VSCode to work with Python virtual environments*
https://code.visualstudio.com/docs/python/environments

*Flask tutorial*
https://code.visualstudio.com/docs/python/tutorial-flask

*Markdown tips*
https://commonmark.org/
