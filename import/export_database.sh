#!/bin/bash

DB=$1

source 'COMMON.sh'
set_data_dir
reset_data_dir

echo "Exporting tables..."
mysqldump -u${LOCAL_DB_USER} -p${LOCAL_DB_PASS} --tab ${DATA_DIR} $DB
echo "Complete"

