#!/bin/bash

## Define type from params, represents rsync module.
BACKUP_TYPE=$2
BACKUP_SUFFIX=tar.gz

## Include common
source /opt/backup_scripts/BACKUP_COMMON.sh

## Require host and type
check_host_type 

/usr/bin/rsync \
--timeout=300 \
--contimeout=30 \
--delete-during \
--archive \
--stats \
${BACKUP_HOST}::${BACKUP_TYPE}/ \
$TMP_FILE && \

## Archive and compress dir
archive_dir && \

## Move file into place
store_files

