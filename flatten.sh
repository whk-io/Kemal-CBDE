#! /bin/bash

# generate uuid
export container_name=$(uuidgen)
# assign uuid to running container name
echo 'running container to export'
echo "container name: $container_name"
docker run -id --name $container_name kemal:latest
# get pid of running container by uuid in name
export DockerID=$(docker ps | grep $container_name | awk '{print $1}')
# export container image by pid
echo 'exporting image to tar'
docker export $DockerID > latest.tar
# kill any running container with matching name
echo 'killing running container'
docker ps | grep $container_name | awk '{print $1}' | xargs docker kill
# clear pid environment variable
echo 'reset id variable'
DockerID=''
# import exported image as single layer
echo 'importing image'
docker import --change "ENTRYPOINT [\"/bin/kemal\"]" \
--change "WORKDIR /bin" \
--change "ENV TERM=dumb" \
--change "ENV HOSTNAME=kemal" \
--change "ENV PWD=/bin" \
--change "ENV HOME=/root" \
--change "ENV SHLVL=1" \
--change "ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
latest.tar kemal-package:flat
# delete exported tar file
echo 'deleting image'
rm latest.tar