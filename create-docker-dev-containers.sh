#!/bin/bash
#Check that input parameters (/path/to/nexus, nexusPort, /path/to/nginxconf, /path/to/nginxhtml, nginxPort) are present. Otherwise return usage message and exit.
if [ $# -ne 5 ]
  then
    echo "Usage: create-docker-dev-containers.sh /path/to/nexus nexusPort /path/to/nginxconf /path/to/nginxhtml nginxPort"
    exit
fi
# Create Docker container for nexus: map the specified nexusPort to the default container port and set the working directory to the /path/to/nexus directory. 
docker run -d -p ${2}:8081 --name nexus3 -v ${1}:/nexus-data sonatype/nexus3
# Create Docker container for nginx: map the specified nginxPort to the default container port and set the config and html directories to /path/to/nginxconf and /path/to/nginxhtml respectively.
docker run -d -p ${5}:80 --name nginx -v ${4}:/usr/share/nginx/html:ro -v ${3}:/etc/nginx/nginx.conf:ro nginx