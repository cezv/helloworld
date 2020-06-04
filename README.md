# Project Notes

## About
Created on Debian 10 (Buster - DE Cinnamon), using Visual Studio Code.

## Current issues
The docker file is building without errors but I'm not able to access the app yet,
a curl to http://127.0.0.1:5000/ comes back with "connection refused" (localhost
and 0.0.0.0 also attempted for troubleshooting):
```
$ curl -v http://127.0.0.1:5000/
* Expire in 0 ms for 6 (transfer 0x5562181d9f50)
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Expire in 200 ms for 4 (transfer 0x5562181d9f50)
* connect to 127.0.0.1 port 5000 failed: Connection refused
* Failed to connect to 127.0.0.1 port 5000: Connection refused
* Closing connection 0
curl: (7) Failed to connect to 127.0.0.1 port 5000: Connection refused
```

The docker image starts and runs with no evident errors (there's a warning):
```
$ sudo docker run helloflask
[2020-06-04 04:24:08 +0000] [1] [INFO] Starting gunicorn 19.9.0
[2020-06-04 04:24:08 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
[2020-06-04 04:24:08 +0000] [1] [INFO] Using worker: sync
/usr/local/lib/python3.8/os.py:1023: RuntimeWarning: line buffering (buffering=1) isn't supported in binary mode, the default buffer size will be used
  return io.open(fd, *args, **kwargs)
[2020-06-04 04:24:08 +0000] [9] [INFO] Booting worker with pid: 9

$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
9cbb841a7236        helloflask          "gunicorn --bind 0.0…"   3 minutes ago       Up 3 minutes        5000/tcp            hopeful_mclaren
```

The project runs well when executed outside of the container.

## Cleared Issues (fixes or workarounds already applied)

Memory problem caused in VBox apparently from a combination of using Cinnamon and
VSCode. Here's the issue https://forums.virtualbox.org/viewtopic.php?t=79136.
This was addressed in 2 ways: increasing the video memory in VBox and disabling 
hardware acceleration in VSCode.

Bumped into this bug https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1635463
which also affects Debian it became evident while building the container. The error 
is introduced after running pip freeze from a virtual environment. The workaround 
applied was removing the line from the requirements.txt

Unable to start the gunicorn server due to missing module. This was just an observation
error of the project tree structure caused by sudden drop in caffeine levels.

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
