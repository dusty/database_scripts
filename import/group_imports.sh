#!/bin/bash

DB=$1

source 'COMMON.sh'
set_data_dir
check_data_dir

echo "Grouping files..."
cd $DATA_DIR

total=0
for file in ${DATA_DIR}/*.txt*; do
  size=`stat -c%s $file`
  total=$((total + size))
done

current_group=1
group[$current_group]=0

# Move the regular .txt files into groups
for file in ${DATA_DIR}/*.txt; do
  size=`stat -c%s $file`
  name=`basename $file`
  group_dir=${DATA_DIR}/GROUP_${current_group}
  mkdir -p $group_dir
  mv $file $group_dir
  echo "  Moved ${name} to ${group_dir}"
  group[$current_group]=$((group[current_group] + size))
  if [ ${group[$current_group]} -gt $GROUP_MAX_SIZE ]; then
    current_group=$((current_group + 1))
  fi
done

# Move the split files into the same groups because
# a write lock will be held on the table
last_prefix=""
for file in ${DATA_DIR}/*.txt_*; do
	name=`basename $file`
	prefix=`echo $name | sed 's/.txt_.*$//g'`
	if [ "$last_prefix" -ne "$prefix" ]; then
	  current_group=$((current_group + 1))
  fi
	group_dir=${DATA_DIR}/GROUP_${current_group}
	mkdir -p $group_dir
	mv $file $group_dir
	echo "  Moved ${name} to ${group_dir}"
	last_prefix=$prefix
done
	  

echo "Complete"

