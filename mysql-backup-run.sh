#!/bin/bash
# This is a shell script to backup a mysql database.
# This can be run using a cron job or simply by executing the script which takes two parameters with the location of the mysql folder and the location where backups should be stored.
# Usage: mysql-backup-run.sh /path/to/mysql /path/to/backup/store

#Check that input parameters (/path/to/mysql and /path/to/backup) are present. Otherwise return usage message and exit.
if [ $# -ne 2 ]
  then
    echo "Usage: mysql-backup-run.sh /path/to/mysql /path/to/backup"
    exit
fi
#Set the name of the file containing the backup - a backup on the 21st December 2016 at 21:00 would have the following name - backup.201612212100.sql
BACKUPFILE=backup.`date +"%Y%m%d%H%M"`.sql
# Call backup method in mysql and redirect output to backup file.
${1}/bin/mysqldump -uroot --all-databases > ${2}/${BACKUPFILE}
#Check if for some reason no data was written in to the file.
if [ ! -s ${2}/${BACKUPFILE} ]
then
    echo 'No data was written - is the database working correctly? Cleaning up empty file...'
    rm ${2}/${BACKUPFILE}
fi