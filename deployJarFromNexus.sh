#!/bin/bash

#Define variables
NAME=$1;
PROFILE=$2

#Create temporary working directory
rm -rf tmp_deployment/
mkdir tmp_deployment
cd tmp_deployment

#Define constants
#This variable should match the group id in maven as a directory path.
PACKAGE="/de/davelee/mypackage"
#This variable should contain the base url to your Nexus Installation.
NEXUS_URL="http://localhost:8002"

#Get the maven metadata file
echo $NEXUS_URL/repository/maven-snapshots/$PACKAGE/$1/maven-metadata.xml
curl -o versions.xml $NEXUS_URL/repository/maven-snapshots/$PACKAGE/$1/maven-metadata.xml

#Retrieve the latest version into a variable.
BASE_VERSION=$(xmllint --xpath '/metadata/versioning/latest/text()' versions.xml)
echo 'Base:'$BASE_VERSION;
if [[ -z "$BASE_VERSION" ]]; then
  BASE_VERSION=$(xmllint --xpath '/metadata/versioning/versions/version/text()' versions.xml)
fi
echo 'Base:'$BASE_VERSION;

#Get the next maven metdata file.
curl -o timestamps.xml $NEXUS_URL/repository/maven-snapshots/$PACKAGE/$1/$BASE_VERSION/maven-metadata.xml

#Retrieve the snapshot timestamp.
SNAPSHOT_TIMESTAMP=$(xmllint --xpath '/metadata/versioning/snapshotVersions/snapshotVersion[1]/value/text()' timestamps.xml)

#Download the jar file.
echo $NEXUS_URL/repository/maven-snapshots/$PACKAGE/$1/$BASE_VERSION/$NAME-$SNAPSHOT_TIMESTAMP.jar
curl -o $NAME.jar $NEXUS_URL/repository/maven-snapshots/$PACKAGE/$1/$BASE_VERSION/$NAME-$SNAPSHOT_TIMESTAMP.jar

#Delete the versions and timestamps files.
#rm timestamps.xml
#rm versions.xml

#Start jar file.
java -jar -Dspring.profiles.active=$PROFILE $NAME.jar
