# devops-scripts

Devops is the culture of bringing development and operations teams together to ensure realistic development environments, faster deployments and less bugs in production. I have been working in this field recently. The scripts in this repository which I have used for private projects help developers to quickly set up their own local environments.

The following scripts are contained in this repository:
* mysql-backup-run.sh is a shell script to backup a mysql database. This can be run using a cron job or simply by executing the script which takes two parameters with the location of the mysql folder and the location where backups should be stored. Usage: mysql-backup-run.sh /path/to/mysql /path/to/backup/store
