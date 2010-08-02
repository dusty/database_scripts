#!/bin/bash

DB=$1
DB_USER=
DB_PASS=
DB_HOST=
BASE_DIR=/mnt/database_exports/data
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
mysqldump -u${DB_USER} --tab ${DATA_DIR} $DB
echo "Complete"
