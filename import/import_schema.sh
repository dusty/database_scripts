#!/bin/bash

DB=$1
SCHEMA=$2
DB_USER=
DB_PASS=
DB_HOST=

BASE_DIR=/mnt/database_exports/data
DATA_DIR=${BASE_DIR}/${DB}

if [ $# -lt 1 ]; then
  echo "Usage: import_schema.sh <database>"
  exit 1
fi

if [ \! -d "$DATA_DIR" ]; then
  echo "Directory ${DATA_DIR} does not exist"
  exit 1
fi

if [ -n "$SCHEMA" ];then
  echo "Importing schema..."
  for schema in ${DATA_DIR}/*.sql; do
    name=`basename $schema`
    echo "  Import: ${name}"
    mysql -u${DB_USER} -p${DB_PASS} -h ${DB_HOST} $DB < $schema
  done
  echo "Complete"
  echo ""
fi

