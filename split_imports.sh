#!/bin/bash

DB=$1
BASE_DIR=/mnt/database_exports/data
DATA_DIR=${BASE_DIR}/${DB}

if [ $# -lt 1 ]; then
  echo "Usage: split_exports.sh <database>"
  exit 1
fi


echo "Splitting files..."
cd $DATA_DIR
for file in ${DATA_DIR}/*.txt; do
  size=`stat -c%s $file`
  name=`basename $file`
  if [ $size -gt 1073741824 ]; then
     echo "  Split: $name"
     split -C 1024m -d $file ${name}_ && rm $file
  else
     echo "  Skip: $name"
  fi
done
echo "Complete"

