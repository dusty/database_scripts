#!/bin/bash

DB=$1

source 'COMMON.sh'
set_data_dir
check_data_dir

echo "Importing schema..."
for schema in ${DATA_DIR}/*.sql; do
  name=`basename $schema`
  echo "  Import: ${name}"
  mysql -u${REMOTE_DB_USER} -p${REMOTE_DB_PASS} -h ${REMOTE_DB_HOST} $DB < $schema
done
echo "Complete"

