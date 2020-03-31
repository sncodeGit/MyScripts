#!/bin/bash

source tmp/vars.env

get_ssh_user(){
  if [[ $(grep "$1" ${GENERAL_INVENTORY}) == *"Bitrix"* ]]
  then
    ssh_user=root
  else
    ssh_user="${SSH_LOGIN}"
  fi
}

# server_name (csXX-client_id)
if [[ "$1" == *"cs"* ]]
then
  server_ip=$(${GENERAL_INVENTORY} $(echo "$1" | cut -d '-' -f 2) | grep "$1" | cut -d ':' -f 2 | cut -d ' ' -f 2)
# ip
elif [[ $(expr match "$1" "[0-9]*\.[0-9]*") -ne 0 ]]
then
  server_ip="$1"
# client_id
else
  server_ip=$(${GENERAL_INVENTORY} "$1" | grep "$1" | cut -d ':' -f 2 | cut -d ' ' -f 2)
fi

if [[ $(echo $server_ip | grep ' ' | wc -l) -eq "0" ]]
then
  get_ssh_user $server_ip
  ssh -l $ssh_user $server_ip
else
  ~/MyScripts/getcl.sh "$1"
  echo -n 'Enter server name or ip: '
  read enter
  ~/MyScripts/goto.sh $enter
fi
