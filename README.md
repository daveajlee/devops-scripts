<p align="center">
<img src="https://www.davelee.de/common/assets/img/portfolio/devopsscripts-white.webp" alt="Devops Scripts" width="300" height="300">
</p>

<p align=center><a href="https://app.codacy.com/manual/dave_33/devops-scripts?utm_source=github.com&utm_medium=referral&utm_content=daveajlee/devops-scripts&utm_campaign=Badge_Grade_Dashboard"><img src="https://api.codacy.com/project/badge/Grade/51dd130072b04844bc98fa7f019ae7d0" alt="Codacy Badge"> </a>
</p>

Devops is the culture of bringing development and operations teams together to ensure realistic development environments, faster deployments and less bugs in production. This repository contains scripts that I have written to help developers to quickly set up their own local development environments.

## Contents

The following scripts are contained in this repository:
| Script File | Description |
| --- | ----------- |
| create-docker-dev-containers.sh | Shell script to create customised docker containers for NGINX and Nexus. The script has been tested on Docker for Mac but should work with all versions of Docker or Docker Toolbox. The script takes parameters to customise the directories and ports used by the two containers. Usage: create-docker-dev-containers.sh /path/to/nexus nexusPort /path/to/nginxconf /path/to/nginxhtml nginxPort |
| deployDockerFromNexus.sh | Shell script to deploy a JAR from a nexus repository in a docker container and start it. The script has been tested on Docker for Mac but should work with all versions of Docker or Docker Toolbox. The script takes parameters to customise the name, port and profile to use. The port must match the port that the JAR normally runs in without Docker. Usage: deployDockerFromNexus.sh nameOfMavenArtifact port springProfile |
| deployJarFromNexus.sh | Shell script to deploy a JAR from a nexus repository. The script takes parameters to customise the name and profile to use. Usage: deployJarFromNexus.sh nameOfMavenArtifact springProfile |
| moveFolderWithinGit.sh | Shell script which moves a particular subfolder from an old folder to a new folder containing the complete git history. Usage: moveFolderWithinGit.sh pathToOldFolder pathToNewFolder subFolderNameOldRepo branchNameInNewRepo subFolderNameNewRepo |
| mysql-backup-run.sh | Shell script to backup a mysql database. This can be run using a cron job or simply by executing the script which takes two parameters with the location of the mysql folder and the location where backups should be stored. Usage: mysql-backup-run.sh /path/to/mysql /path/to/backup/store |
| nginxsshrenewal.sh | Shell script to automate the renewal of letsencrypt certificates with nginx. It assumes that certbot and nginx are correctly configured and takes no parameters. |
| restartdocker.sh | Shell script to restart the specified docker container with a newly built image. It automatically removes all traces of the previous docker container and image and builds a new image and deploys this within a container. The script has been tested on Docker for Mac but should work with all versions of Docker or Docker Toolbox. Usage: restartdocker.sh imageAndContainerName portToRunOn |

Additionally there is a folder called DevMicroserviceEnvironment which contains the following files:
| File | Description |
| --- | ----------- |
| docker-compose.yml | YAML File for Docker Compose which sets up a complete microservice developer environment including a Jenkins 2 instance, a Nexus 3 repository, an NGINX web server, a Eureka Server and a Spring Boot Admin Server. Usage: navigate to this directory and run docker-compose up -d  |
| java-microservice-Jenkinsfile | Jenkinsfiles containing a Jenkins 2 pipeline which builds a Maven Java project from a git repository and runs JUnit tests, does a Checkstyle and FindBugs analysis and publishes the results. It can be extended as necessary. Usage: integrate this Jenkinsfile into a Jenkins 2 instance and change the git and nexus urls as indicated in the Jenkinsfile |
