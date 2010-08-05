#!/bin/bash

DB=$1
GROUP=$2

source 'COMMON.sh'
set_group_data_dir
check_data_dir

echo "Importing data..."
mysqlimport -u${REMOTE_DB_USER} -p${REMOTE_DB_PASS} -h ${REMOTE_DB_HOST} --local $DB ${DATA_DIR}/*.txt*
echo "Complete"

