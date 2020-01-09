#!/bin/bash

set -e
./scripts/pre_requisites.sh

tag=$(date +"%g%m.%d%H")

echo "Creating version ${tag}"

# Build the rover base image
sudo docker-compose build

sudo docker tag rover_rover aztfmod/rover:$tag
sudo docker tag rover_rover aztfmod/rover:latest

if [[ $1 -ne "local" ]]; then
    sudo docker push aztfmod/rover:$tag
    sudo docker push aztfmod/rover:latest
    # tag the git branch and push
    git tag $tag master
    git push --follow-tags
fi

echo "Version ${tag} created."