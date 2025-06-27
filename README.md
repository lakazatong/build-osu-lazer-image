# osu-server Docker Setup
This repository sets up a Dockerized environment for running a modded osu! with .NET 8.0.  
To know more about how it's modded and how it can be interacted with, check out [osu-server](https://github.com/lakazatong/osu-server) and [osu-framework-server](https://github.com/lakazatong/osu-framework-server).
## Docker Build and Run Instructions
### 1. Build the Docker Image
```
./build.sh
```
This will build the Docker image tagged as `osu-server`.  
For more information, use `--help`.
### 3. Running the Docker Container
```
docker run -p 8080:8080 -it --name <container_name> osu-server
```
You will see a bunch of
```
Failed to read: XXX
Setting default value
```
That's perfectly normal, it's fluxbox not finding any fluxbox config, it thus uses the defaults.
### 4. Running the osu! Game
In /osu-server:
```
dotnet run --project osu.Desktop
```
### 5. Reattach to an Already Running Container
```
docker start -ai <container_name>
```
Replace `<container_name>` with the name or ID of the container you wish to attach to.  
If you need to find the container name or ID:
```
docker ps -a
```
## Warning
The built images are huge, they are not meant to be used in production.  
You probably noticed the git pulls, which obviously goes against what docker is used for, reproducibility.
The instructions to build production ready images are yet to be added.