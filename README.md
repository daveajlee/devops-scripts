# devops-scripts

Devops is the culture of bringing development and operations teams together to ensure realistic development environments, faster deployments and less bugs in production. I have been working in this field recently. The scripts in this repository which I have used for private projects help developers to quickly set up their own local environments.

The following scripts are contained in this repository:
* create-docker-dev-containers.sh is a shell script to create customised docker containers for NGINX and Nexus. The script has been tested on Docker for Mac but should work with all versions of Docker or Docker Toolbox. The script takes parameters to customise the directories and ports used by the two containers. Usage: create-docker-dev-containers.sh /path/to/nexus nexusPort /path/to/nginxconf /path/to/nginxhtml nginxPort
* mysql-backup-run.sh is a shell script to backup a mysql database. This can be run using a cron job or simply by executing the script which takes two parameters with the location of the mysql folder and the location where backups should be stored. Usage: mysql-backup-run.sh /path/to/mysql /path/to/backup/store
* nginxsshrenewal.sh is a shell script to automate the renewal of letsencrypt certificates with nginx. It assumes that certbot and nginx are correctly configured and takes no parameters.
