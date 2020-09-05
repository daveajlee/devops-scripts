#!/bin/bash

#Set variables.
NAME=$1;
PORT=$2;

#Define constants
#This variable should contain the prefix/group id for your docker container.
PREFIX="prefix"

#If a container is already running with this name, then stop and delete it.
if [  "$(docker ps -q -f name=$NAME)" ]; then
  # stop and clean up
  docker stop $NAME
  docker rm $NAME
fi
#If a container with this name is already stopped but not deleted, then delete it.
if [  "$(docker ps -aq -f status=exited -f name=$NAME)" ]; then
  # cleanup
  docker rm $NAME
fi
#Remove the image if it exists
if [ "$(docker images -q $PREFIX/$NAME)" ]; then
  #Remove image
  docker rmi $PREFIX/$NAME
fi
#Now rebuild the image
docker build -t $PREFIX/$NAME .
#Now start the container
docker run -d -p $PORT:$PORT --name $NAME -t $PREFIX/$NAME
