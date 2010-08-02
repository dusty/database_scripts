#!/bin/bash

## Configure
BACKUP_DIR=/backup
RSYNC_MODULE=backup

## Variables
BACKUP_HOST=$1

if [ -z "${BACKUP_HOST}" ]; then
  echo "Usage: ${0} <hostname>"
  exit 1
fi

/usr/bin/rsync \
--timeout=300 \
--contimeout=30 \
--archive \
--stats \
--exclude 'lost+found' \
${BACKUP_HOST}::${RSYNC_MODULE}/ \
${BACKUP_DIR}

