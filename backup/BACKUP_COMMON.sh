## Rotation parameters
WEEKLY_ROTATION_DAY="Sun"
MONTHLY_ROTATION_DAY="01"

## Directories
TMP_DIR=/backup/tmp
OUT_DIR=/backup/incoming
DAILY_DIR=/backup/daily
WEEKLY_DIR=/backup/weekly
MONTHLY_DIR=/backup/monthly

## Generated Variables
BACKUP_HOST=$1
DATE_STRING="$(date +"%Y%m%d")"
OUT_NAME="${BACKUP_HOST}-${BACKUP_TYPE}-${DATE_STRING}"
TMP_FILE="${TMP_DIR}/${OUT_NAME}"
OUT_FILE="${OUT_DIR}/${OUT_NAME}.${BACKUP_SUFFIX}"

function check_host() {
  ## Make sure BACKUP_HOST is provided
  if [ -z "${BACKUP_HOST}" ]; then
    echo "Usage: ${0} <hostname>"
    exit 1
  fi
  ## Make sure BACKUP_TYPE is defined
  if [ -z "${BACKUP_TYPE}" ]; then
    echo "You must define BACKUP_TYPE (eg: mysql)"
    exit 1
  fi
  ## Define BACKUP_SUFFIX
  if [ -z "${BACKUP_SUFFIX}" ]; then
    echo "You must define BACKUP_SUFFIX (eg: tar.gz)"
    exit 1
  fi
}

function check_host_type() {
  if [ -z "${BACKUP_HOST}" ] || [ -z "${BACKUP_TYPE}" ]; then
    echo "Usage: ${0} <hostname> <module>"
    exit 1
  fi
  ## Define BACKUP_SUFFIX
  if [ -z "${BACKUP_SUFFIX}" ]; then
    echo "You must define BACKUP_SUFFIX (eg: tar.gz)"
    exit 1
  fi
}

function archive_dir() {
  cd $TMP_DIR && \
  tar cvfz $OUT_FILE $OUT_NAME && \
  rm -fr $OUT_NAME
}

function store_files() {
  ## Hard link to monthly
  if [ "$(date "+%d")" == $MONTHLY_ROTATION_DAY ]; then
    ln -f $OUT_FILE $MONTHLY_DIR
  fi
  ## Hard link to weekly
  if [ "$(date "+%a")" == $WEEKLY_ROTATION_DAY ]; then
    ln -f $OUT_FILE $WEEKLY_DIR
  fi
  ## Move to daily
  mv $OUT_FILE $DAILY_DIR
}
