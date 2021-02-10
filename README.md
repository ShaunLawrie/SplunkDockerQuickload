# How To

Splunk default password is prompted for in ./Run.ps1  
This uses the config specified in Variables.ps1 for naming most things.  

## Windows / Mac

Windows note: Have 7zip installed in the default location  
NOTE: Confirm the docker image and container name specified in Variables.ps1 does not collide with any of your local docker configuration.

1. ./Build.ps1
2. ./Run.ps1

## Other

To create a new docker image:  
`docker build --tag=splunkimage .`  

To run a new container:  
`docker run -d --name splunkcontainername -p 8000:8000 splunkimage`

To debug docker failures tail the logs from the container:  
`docker logs -f splunkcontainername`

To get a remote session in the docker container use:  
`docker exec -it splunkcontainername bash`
