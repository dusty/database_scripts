#!/bin/bash

source 'COMMON.sh'

DB=$1
DATA_DIR=${BASE_DIR}/${DB}

if [ $# -lt 1 ]; then
  echo "Usage: group_exports.sh <database>"
  exit 1
fi

echo "Grouping files..."
cd $DATA_DIR

total=0
for file in ${DATA_DIR}/*.txt*; do
  size=`stat -c%s $file`
  total=$((total + size))
done
group_size=$((total / GROUP_COUNT))

current_group=1
group[$current_group]=0

for file in ${DATA_DIR}/*.txt*; do
  size=`stat -c%s $file`
  name=`basename $file`
  group_dir=${DATA_DIR}/GROUP_${current_group}
  mkdir -p $group_dir
  mv $file $group_dir
  echo "  Moved ${name} to ${group_dir}"
  group[$current_group]=$((group[current_group] + size))
  if [ ${group[$current_group]} -gt $group_size ]; then
    current_group=$((current_group + 1))
  fi
done

echo "Complete"

