#!/bin/bash
# This is a shell script to deploy a JAR from a nexus repository in a docker container and start it.
# The script has been tested on Docker for Mac but should work with all versions of Docker or Docker Toolbox.
# The script takes parameters to customise the name, port and profile to use.
# The port must match the port that the JAR normally runs in without Docker.
# Usage: deployDockerFromNexus.sh nameOfMavenArtifact port springProfile

#Define variables
NAME=$1;
PORT=$2;
SPRING_PROFILE=$3;

#Define constants
#This variable should match the group id in maven as a directory path.
PACKAGE="/de/davelee/mypackage"
#This variable should contain the base url to your Nexus Installation.
NEXUS_URL="http://localhost:8002"
#This variable should contain the prefix/group id for your docker container.
PREFIX="prefix"

#Create temporary working directory
rm -rf tmp_deployment/
mkdir tmp_deployment
cd tmp_deployment

#Get the maven metadata file
curl -o versions.xml "$NEXUS_URL"/repository/maven-snapshots/"$PACKAGE"/"$1"/maven-metadata.xml

#Retrieve the latest version into a variable.
BASE_VERSION=$(xmllint --xpath '/metadata/versioning/latest/text()' versions.xml)

#Check if base version was null.
if [ -z "$BASE_VERSION" ]; then
  #This is necessary since when only one version no latest tag
  BASE_VERSION=$(xmllint --xpath '/metadata/versioning/versions/version/text()' versions.xml);
  echo "$BASE_VERSION";
  if [ -z "$BASE_VERSION" ]; then
    echo 'Base version not set';
    exit 1;
  fi
fi

#Get the next maven metdata file.
curl -o timestamps.xml "$NEXUS_URL"/repository/maven-snapshots/"$PACKAGE"/"$1"/"$BASE_VERSION"/maven-metadata.xml

#Retrieve the snapshot timestamp.
SNAPSHOT_TIMESTAMP=$(xmllint --xpath '/metadata/versioning/snapshotVersions/snapshotVersion[1]/value/text()' timestamps.xml)
echo 'Snapshot Timestamp: '$SNAPSHOT_TIMESTAMP;
if [ -z "$SNAPSHOT_TIMESTAMP" ]; then
  echo 'Snapshot timestamp not set';
  exit 1;
fi

#Download the jar file.
curl -o "$1".jar "$NEXUS_URL"/repository/maven-snapshots/"$PACKAGE"/"$1"/"$BASE_VERSION"/"$NAME"-"$SNAPSHOT_TIMESTAMP".jar

#Delete the versions and timestamps files.
rm timestamps.xml
rm versions.xml

#Generate the docker file automatically.
echo 'FROM openjdk:8-jdk-alpine' > Dockerfile
echo 'VOLUME /tmp' >> Dockerfile
echo 'ADD '$NAME'.jar app.jar' >> Dockerfile
echo 'ENV JAVA_OPTS=""' >> Dockerfile
echo 'ENV PROFILE='$SPRING_PROFILE >> Dockerfile
echo 'ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]' >> Dockerfile

#If a container is already running with this name, then stop and delete it.
if [  "$(docker ps -q -f name=$NAME)" ]; then
  # stop and clean up
  docker stop "$NAME"
  docker rm "$NAME"
fi
#If a container with this name is already stopped but not deleted, then delete it.
if [  "$(docker ps -aq -f status=exited -f name=$NAME)" ]; then
  # cleanup
  docker rm "$NAME"
fi
#Remove the image if it exists
if [ "$(docker images -q $PREFIX/$NAME)" ]; then
  #Remove image
  docker rmi "$PREFIX"/"$NAME"
fi
#Now rebuild the image
docker build -t "$PREFIX"/"$NAME" .

#Now start the container
docker run -d -p "$PORT":"$PORT" --name "$NAME" -t "$PREFIX"/"$NAME"
