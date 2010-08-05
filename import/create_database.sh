#!/bin/bash

DB=$1

source 'COMMON.sh'
set_data_dir

echo "Creating database ${DB}..."
echo "create database ${DB}" | mysql -u${REMOTE_DB_USER} -p${REMOTE_DB_PASS} -h ${REMOTE_DB_HOST}
echo "Complete"

