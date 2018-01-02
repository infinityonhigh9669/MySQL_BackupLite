#!/bin/sh

COMPRESSION_COMMAND="gzip -f -9"

MYSQLDUMP="/usr/bin/mysqldump --user= --password= --all-databases"
MYSQLDUMP_DIR=

VARDATE=`date +%Y%m%d`
HOSTNAME=`hostname`

# connection info
REMOTE_HOST=
REMOTE_USER=
REMOTE_PORT=
# path to private key
KEY=
# path to pull files from
LOCAL_PATH=
# path to push files to
REMOTE_PATH=

# start the sqldump and compression
/bin/mkdir $MYSQLDUMP_DIR/$VARDATE
$MYSQLDUMP > $MYSQLDUMP_DIR/$VARDATE/$HOSTNAME-mysql-all.sql
$COMPRESSION_COMMAND $MYSQLDUMP_DIR/$VARDATE/$HOSTNAME-mysql-all.sql

# start the backup
rsync -au -v -e 'ssh -p '$REMOTE_PORT'' $LOCAL_PATH/$VARDATE $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH