#!/bin/bash

source ${HOME}/MyScripts/tmp/vars.env

cd "$GOOGLE_DISK_BACKUP_DIR"

DIRS=$(find . -type d | grep /)

for DIR in ${DIRS}
do
  FILES=$(find ${DIR} -type f)
  for FILE in ${FILES}
  do
    INIT_FILE=$(cat ${FILE} | grep '__auto__sncodegit__init__:' | cut -d ':' -f 2)
    if [[ "$INIT_FILE" == "/ClippingsBackup" ]]
    then
      cd ${DIR}
      CLIPPINGS_COUNT=$(ls -l -c -t | grep -v 'total ' | grep -v $FILE | wc -l)
      if (( "$CLIPPINGS_COUNT" <= "10" ))
      then
        exit 0
      fi
      rm -f $(ls -l -c -t | grep -v 'total ' | grep -v $FILE | tail -n $(($CLIPPINGS_COUNT - 10)) | awk {'print $9'})
      exit 0
    fi
  done
done
