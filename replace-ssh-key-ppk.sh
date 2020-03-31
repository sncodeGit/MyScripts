#!/bin/bash

source ${HOME}/MyScripts/tmp/vars.env

# $1 - ppk key

puttygen "$1" -O private-openssh -o /tmp/id_rsa
puttygen "$1" -O public-openssh -o /tmp/id_rsa.pub

~/MyScripts/replace-ssh-key.sh "/tmp/id_rsa.pub" "/tmp/id_rsa"

rm /tmp/id_rsa.pub /tmp/id_rsa

exit 0
