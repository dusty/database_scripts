# define path to data 
BASE_DIR=/mnt/database_exports/data

# local database authentication
LOCAL_DB_USER=
LOCAL_DB_PASS=

# remote database authentication
REMOTE_DB_USER=
REMOTE_DB_PASS=
REMOTE_DB_HOST=

# number of bytes to trigger split
SPLIT_FILE_SIZE=1073741824

# arguments to split
SPLIT_SIZE_PARAM=1024m

# number of groups for concurrent imports
GROUP_COUNT=5

function set_data_dir() {
  if [ -z "$DB" ]; then
    echo "Usage: $0 <database>"
    exit 1
  fi
  DATA_DIR=${BASE_DIR}/${DB}
}

function set_group_data_dir() {
  if [ -z "$DB" ]; then
    echo "Usage: $0 <database> (group)"
    exit 1
  fi
  if [ -z "$GROUP" ]; then
    DATA_DIR=${BASE_DIR}/${DB}
  else
    DATA_DIR=${BASE_DIR}/${DB}/GROUP_${GROUP}
  fi
}

function check_data_dir() {
  if [ \! -d "$DATA_DIR" ]; then
    echo "Directory ${DATA_DIR} does not exist"
    exit 1
  fi
}

function reset_data_dir() {
  if [ -d "$DATA_DIR" ]; then
    rm -fr $DATA_DIR
  fi
  mkdir -p $DATA_DIR
  chmod 777 $DATA_DIR
}
