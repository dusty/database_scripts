#!/bin/bash

source 'COMMON.sh'

DB=$1
GROUP=$2

if [ -n "$GROUP" ]; then
  DATA_DIR=${BASE_DIR}/${DB}/GROUP_${GROUP}
else
  DATA_DIR=${BASE_DIR}/${DB}
fi

if [ $# -lt 1 ]; then
  echo "Usage: import_data.sh <database> (group)"
  exit 1
fi

if [ \! -d "$DATA_DIR" ]; then
  echo "Directory ${DATA_DIR} does not exist"
  exit 1
fi

echo "Importing data..."
mysqlimport -u${REMOTE_DB_USER} -p${REMOTE_DB_PASS} -h ${REMOTE_DB_HOST} --local $DB ${DATA_DIR}/*.txt*
echo "Complete"

