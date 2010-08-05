#!/bin/bash

DB=$1

source 'COMMON.sh'
set_data_dir

echo "Splitting files..."
cd $DATA_DIR
for file in ${DATA_DIR}/*.txt; do
  size=`stat -c%s $file`
  name=`basename $file`
  if [ $size -gt $SPLIT_FILE_SIZE ]; then
     echo "  Split: $name"
     split -C $SPLIT_SIZE_PARAM -d $file ${name}_ && rm $file
  else
     echo "  Skip: $name"
  fi
done
echo "Complete"

