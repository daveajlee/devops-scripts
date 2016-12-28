#!/bin/bash
#Set the name of the file containing the backup - a backup on the 21st December 2016 at 21:00 would have the following name - backup.201612212100.sql
BACKUPFILE=backup.`date +"%Y%m%d%H%M"`.sql
# Change /path/to/mysql to the root folder of your mysql installation and /path/to/backup to the directory where backups should be stored.
/path/to/mysql/bin/mysqldump -uroot --all-databases > /path/to/backup/${BACKUPFILE}