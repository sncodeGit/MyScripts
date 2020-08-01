#!/bin/bash

# $1 - executable function
BASIC_AUTH_USER="$2"
BASIC_AUTH_PASSWORD="$3"
REGISTRY_HOST="$4"

function f_gettoken {
    local registryURL="https://${REGISTRY_HOST}/v2/_catalog"
    local respHeader=$(tempfile); curl -ks --dump-header $respHeader $registryURL > /dev/null
    local wwwAuth=$(cat $respHeader | grep "www-authenticate")
    local realm=$(echo $wwwAuth | grep -o '\(realm\)="[^"]*"' | cut -d '"' -f 2)
    local service=$(echo $wwwAuth | grep -o '\(service\)="[^"]*"' | cut -d '"' -f 2 | sed "s/ /%20/")
    local scope=$(echo $wwwAuth | grep -o '\(scope\)="[^"]*"' | cut -d '"' -f 2)
    local authURL="$realm?service=$service&scope=$scope"
    local B_AUTH=$(echo -ne "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" | base64 --wrap 0)
    local token=$(curl -ks -H "Authorization: Basic $B_AUTH" "$authURL" | jq -r .access_token)
    echo -n ${token}
}

function f_curllist {
    local registryURL="$1"
    local respHeader=$(tempfile); curl -ks --dump-header $respHeader $registryURL > /dev/null
    local wwwAuth=$(cat $respHeader | grep "www-authenticate")
    local realm=$(echo $wwwAuth | grep -o '\(realm\)="[^"]*"' | cut -d '"' -f 2)
    local service=$(echo $wwwAuth | grep -o '\(service\)="[^"]*"' | cut -d '"' -f 2 | sed "s/ /%20/")
    local scope=$(echo $wwwAuth | grep -o '\(scope\)="[^"]*"' | cut -d '"' -f 2)
    local authURL="$realm?service=$service&scope=$scope"
    local B_AUTH=$(echo -ne "$BASIC_AUTH_USER:$BASIC_AUTH_PASSWORD" | base64 --wrap 0)
    local token=$(curl -ks -H "Authorization: Basic $B_AUTH" "$authURL" | jq -r .access_token)
    curl -ks -H "Authorization: Bearer $token" "$registryURL"
}

function f_repolist {
  f_curllist https://${REGISTRY_HOST}/v2/_catalog | jq -r '.repositories|.[]'
}

function f_jrepo {
  f_curllist https://${REGISTRY_HOST}/v2/_catalog
}

function f_greprepo {
  local repo="$1"
  f_repolist | grep $repo
}

function f_imagetags {
  local tag="$1"
  f_curllist https://${REGISTRY_HOST}/v2/$tag/tags/list | jq -r '.tags|.[]?'
}

function f_jimagetags {
  local tag="$1"
  f_curllist https://${REGISTRY_HOST}/v2/$tag/tags/list
}

function f_list {
# build a list of all images & tags
local tag="$1"
if [ -z "$tag" ]; then
  for i in $(f_repolist)
    do
      # get tags for repo
      IMAGE_TAGS=$(f_imagetags $i)
      # build a list of images from tags
      for j in ${IMAGE_TAGS}
      do
        # add each tag to list
        FULL_IMAGE_LIST="${FULL_IMAGE_LIST} ${i}:${j}"
      done
    done
elif [ -n "$tag" ]; then
    IMAGE_TAGS=$(f_imagetags $tag)
    # build a list of images from tags
    for j in ${IMAGE_TAGS}
    do
      # add each tag to list
      FULL_IMAGE_LIST="${FULL_IMAGE_LIST} ${j}"
    done
fi
# output list of all docker images
for i in ${FULL_IMAGE_LIST}
do
  echo ${i}
done
}

function f_jlist {
local tag="$1"
if [ -z "$tag" ]; then
  for i in $(f_repolist)
    do
      f_jimagetags $i | jq -r '.name + ":" + .tags[]?'
    done
elif [ -n "$tag" ]; then
  f_jimagetags $tag | jq -r '.name + ":" + .tags[]?'
fi
}

eval $1