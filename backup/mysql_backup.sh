#!/bin/bash

## Configure
BACKUP_CMD=/usr/bin/mysqldump
BACKUP_TYPE=mysql
BACKUP_SUFFIX=sql.gz
DB_USER=
DB_PASS=

## Require common
source /opt/backup_scripts/BACKUP_COMMON.sh

## Require host
check_host

## Run
$BACKUP_CMD \
--host=${BACKUP_HOST} \
--user=${DB_USER} \
--password=${DB_PASS} \
--master-data=2 \
--flush-logs \
--all-databases \
--opt | gzip > $TMP_FILE && \

## Atomic move 
mv $TMP_FILE $OUT_FILE && \

## Move files into place
store_files

