#!/bin/sh

set -e

DB_PASSWORD="${INPUT_DATABASE_PASSWORD}"
DB_USERNAME="${INPUT_DATABASE_USERNAME}"
DB_NAME="${INPUT_DATABASE_NAME}"
DB_HOST="${INPUT_DATABASE_HOST}"
DB_PORT="${INPUT_DATABASE_PORT:-3306}"

DUMP_PATH="${INPUT_DUMPFILE_PATH:-backup}"
TIME=`/bin/date +%d-%m-%Y-%T`

DEFAULT_DUMPFILE="${INPUT_DUMPFILE_PATH:-$DB_NAME}"
DUMP_FILE="$DEFAULT_DUMPFILE.sql.tar.gz"

mkdir -p $DUMP_PATH
cd $DUMP_PATH

echo "Dumping database now."
echo "Backing dump to $DUMP_PATH/$DUMP_FILE, use BACKUP_DUMP_FILE enviroment to access the file"
echo "FileName is set as BACKUP_DUMP_FILENAME $DUMP_FILE"
echo "::set-env name=BACKUP_DUMP_FILE_LOCATION::$DUMP_PATH/$DUMP_FILE"
echo "::set-env name=BACKUP_DUMP_FILENAME::$DUMP_FILE"
mysqldump -h $DB_HOST -u $DB_USERNAME -p$DB_PASSWORD --single-transaction=TRUE $DB_NAME | pv --progress --size 100m | gzip > ./$DUMP_FILE
echo "Complete"