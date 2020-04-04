#!/bin/bash

source ${HOME}/MyScripts/tmp/vars.env

get_ssh_user(){
  if [[ $(grep "$1" ${GENERAL_INVENTORY}) == *"Bitrix"* ]]
  then
    echo root
  else
    echo "${SSH_LOGIN}"
  fi
}

# server_name (csXX-client_id)
if [[ "$1" == *"cs"* ]]
then
  server_ip=$(cat ${GENERAL_INVENTORY} | grep "$1" | grep ansible_ssh_host | cut -d '=' -f 2 | cut -d ' ' -f 1)
# ip
elif [[ $(expr match "$1" "[0-9]*\.[0-9]*") -ne 0 ]]
then
  server_ip="$1"
# client_id
else
  server_ip=$(cat ${GENERAL_INVENTORY} | grep "$1" | grep ansible_ssh_host | cut -d '=' -f 2 | cut -d ' ' -f 1)
fi

if [[ $(echo "$server_ip" | wc -l) -eq "1" ]]
then
  ssh -l $(get_ssh_user "$server_ip") "$server_ip"
else
  ~/MyScripts/getcl.sh "$1"
  echo -n 'Enter server name or ip: '
  read enter
  ~/MyScripts/goto.sh $enter
fi
