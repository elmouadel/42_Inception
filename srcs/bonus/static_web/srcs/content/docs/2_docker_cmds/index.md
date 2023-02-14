---
title: 'Docker Commands '
date: 2019-02-11T19:27:37+10:00
weight: 5
---
Docker Commands:
----------------
```
COMMAND             DESCRIPTION
-------             -----------
> docker attach       #Attach local standard input, output, and error streams to a running container
> docker build        #Build an image from a Dockerfile
> docker builder      #Manage builds
> docker checkpoint   #Manage checkpoints
> docker commit       #Create a new image from a container’s changes
> docker config       #Manage Swarm configs
> docker container    #Manage containers
> docker context      #Manage contexts
> docker cp           #Copy files/folders between a container and the local filesystem
> docker create       #Create a new container
> docker diff         #Inspect changes to files or directories on a container’s filesystem
> docker events       #Get real time events from the server
> docker exec         #Execute a command in a running container
> docker export       #Export a container’s filesystem as a tar archive
> docker history      #Show the history of an image
> docker image        #Manage images
> docker images       #List images
> docker import       #Import the contents from a tarball to create a filesystem image
> docker info         #Display system-wide information
> docker inspect      #Return low-level information on Docker objects
> docker kill         #Kill one or more running containers
> docker load         #Load an image from a tar archive or STDIN
> docker login        #Log in to a registry
> docker logout       #Log out from a registry
> docker logs         #Fetch the logs of a container
> docker manifest     #Manage Docker image manifests and manifest lists
> docker network      #Manage networks
> docker node         #Manage Swarm nodes
> docker pause        #Pause all processes within one or more containers
> docker plugin       #Manage plugins
> docker port         #List port mappings or a specific mapping for the container
> docker ps           #List containers
> docker pull         #Download an image from a registry
> docker push         #Upload an image to a registry
> docker rename       #Rename a container
> docker restart      #Restart one or more containers
> docker rm           #Remove one or more containers
> docker rmi          #Remove one or more images
> docker run          #Create and run a new container from an image
> docker save         #Save one or more images to a tar archive (streamed to STDOUT by default)
> docker search       #Search Docker Hub for images
> docker secret       #Manage Swarm secrets
> docker service      #Manage Swarm services
> docker stack        #Manage Swarm stacks
> docker start        #Start one or more stopped containers
> docker stats        #Display a live stream of container(s) resource usage statistics
> docker stop         #Stop one or more running containers
> docker swarm        #Manage Swarm
> docker system       #Manage Docker
> docker tag          #Create a tag TARGET\_IMAGE that refers to SOURCE\_IMAGE
> docker top          #Display the running processes of a container
> docker trust        #Manage trust on Docker images
> docker unpause      #Unpause all processes within one or more containers
> docker update       #Update configuration of one or more containers
> docker version      #Show the Docker version information
> docker volume       #Manage volumes
> docker wait         #Block until one or more containers stop, then print their exit codes

```

Docker-compose Args:
--------------------

```
> Docker-compose [ARG]:

    > build              #Build or rebuild services
    > bundle             #Generate a Docker bundle from the Compose file
    > config             #Validate and view the Compose file
    > create             #Create services
    > down               #Stop and remove containers, networks, images, and volumes
    > events             #Receive real time events from containers
    > exec               #Execute a command in a running container
    > help               #Get help on a command
    > images             #List images
    > kill               #Kill containers
    > logs               #View output from containers
    > pause              #Pause services
    > port               #Print the public port for a port binding
    > ps                 #List containers
    > pull               #Pull service images
    > push               #Push service images
    > restart            #Restart services
    > rm                 #Remove stopped containers
    > run                #Run a one-off command
    > scale              #Set number of containers for a service
    > start              #Start services
    > stop               #Stop services
    > top                #Display the running processes
    > unpause            #Unpause services
    > up                 #Create and start containers
    > version            #Show the Docker Compose version information
```