#!/bin/bash

source ${HOME}/MyScripts/tmp/vars.env

cd ~/.ssh

if [[ -f id_rsa.pub.save && -f id_rsa.save ]]
then
  rm id_rsa id_rsa.pub
  mv id_rsa.save id_rsa
  mv id_rsa.pub.save id_rsa.pub
  exit 0
else
  echo "No found ssh-keys save copy" &>2
  exit 1
fi
