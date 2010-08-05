#!/bin/bash

DB=$1
GROUP=$2
DB_USER=
DB_PASS=
DB_HOST=

BASE_DIR=/mnt/database_exports/data

if [ -n "$GROUP" ];then
  DATA_DIR=${BASE_DIR}/${DB}
else
  DATA_DIR=${BASE_DIR}/${DB}/GROUP_${GROUP}
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
mysqlimport -u${DB_USER} -p${DB_PASS} -h ${DB_HOST} --local $DB ${DATA_DIR}/*.txt*
echo "Complete"

