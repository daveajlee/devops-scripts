#!/bin/bash
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