## Directories
MIRROR_DIR=/backup/mirrors

## Generated Variables
BACKUP_HOST=$1
BACKUP_MODULE=$2
RSYNC_SOURCE="${BACKUP_HOST}::${BACKUP_MODULE}/"
RSYNC_DESTINATION="${MIRROR_DIR}/${BACKUP_HOST}/${BACKUP_MODULE}"

if [ -z "${BACKUP_HOST}" ] || [ -z "${BACKUP_MODULE}" ]; then
  echo "Usage: ${0} <hostname> <module>"
  exit 1
fi

mkdir -p $RSYNC_DESTINATION

/usr/bin/rsync \
--timeout=300 \
--contimeout=30 \
--delete-during \
--archive \
--stats \
$RSYNC_SOURCE \
$RSYNC_DESTINATION

