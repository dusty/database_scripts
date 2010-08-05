#!/bin/bash

source 'COMMON.sh'

DB=$1
DATA_DIR=${BASE_DIR}/${DB}

if [ $# -lt 1 ]; then
  echo "Usage: import_schema.sh <database>"
  exit 1
fi

if [ \! -d "$DATA_DIR" ]; then
  echo "Directory ${DATA_DIR} does not exist"
  exit 1
fi

echo "Importing schema..."
for schema in ${DATA_DIR}/*.sql; do
  name=`basename $schema`
  echo "  Import: ${name}"
  mysql -u${REMOTE_DB_USER} -p${REMOTE_DB_PASS} -h ${REMOTE_DB_HOST} $DB < $schema
done
echo "Complete"

