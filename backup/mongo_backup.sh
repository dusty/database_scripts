#!/bin/bash

## Configure
BACKUP_CMD=/opt/mongodb-1.4.3/bin/mongodump
BACKUP_TYPE=mongo
BACKUP_SUFFIX=tar.gz

## Require common
source /opt/backup_scripts/BACKUP_COMMON.sh

## Require host
check_host

## Run
$BACKUP_CMD \
--host $BACKUP_HOST \
--out $TMP_FILE && \

## Archive and compress dir
archive_dir && \

## Move file into place
store_files

