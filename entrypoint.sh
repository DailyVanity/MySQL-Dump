#!/bin/sh

set -e

DB_PASSWORD="${INPUT_DATABASE_PASSWORD}"
DB_USERNAME="${INPUT_DATABASE_USERNAME}"
DB_NAME="${INPUT_DATABASE_NAME}"
DB_HOST="${INPUT_DATABASE_HOST}"
DB_PORT="${INPUT_DATABASE_PORT:-3306}"

DUMP_PATH="${INPUT_DUMPFILE_PATH:-backup}"
TIME=`/bin/date +%d-%m-%Y-%T`

DEFAULT_DUMPFILE=$DB_NAME.sql.gz
DUMP_FILE="${INPUT_DUMPFILE_PATH:-$DEFAULT_DUMPFILE}"

mkdir -p $DUMP_PATH
cd $DUMP_PATH

echo "Dumping database now."
mysqldump -h $DB_HOST -u $DB_USERNAME -p$DB_PASSWORD --single-transaction=TRUE $DB_NAME | pv --progress --size 100m | gzip > ./$DUMP_FILE
echo "Complete"