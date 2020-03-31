#!/bin/bash

source ${HOME}/MyScripts/tmp/vars.env

# $1 - public key
# $2 - private key

mv ~/.ssh/id_rsa ~/.ssh/id_rsa.save
mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.save

cp "$1" ~/.ssh/id_rsa.pub
cp "$2" ~/.ssh/id_rsa

exit 0
