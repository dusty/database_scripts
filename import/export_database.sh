#!/bin/bash

source 'COMMON.sh'

DB=$1
DATA_DIR=${BASE_DIR}/${DB}

if [ $# -lt 1 ]; then
  echo "Usage: export_database.sh <database>"
  exit 1
fi

if [ -d "$DATA_DIR" ]; then
  rm -fr $DATA_DIR
fi

mkdir -p $DATA_DIR
chmod 777 $DATA_DIR

echo "Exporting tables..."
mysqldump -u${LOCAL_DB_USER} -p${LOCAL_DB_PASS} --tab ${DATA_DIR} $DB
echo "Complete"
