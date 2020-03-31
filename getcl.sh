#!/bin/bash

source ${HOME}/MyScripts/tmp/vars.env

data=`cat ${GENERAL_INVENTORY} | grep "$cs[0-9][0-9]-$1" | grep ssh_host | cut -d '#' -f 1 | sed -r '/$^/d'`

flag=0

for i in $data
do
  if (( $flag == 0 ))
  then
    echo -n "$i : "
    flag=1
  else
    i=`echo $i | cut -d '=' -f 2`
    echo $i
    flag=0
  fi
done
