set -ex

docker run -it --rm \
 --name angie-wmx \
 --hostname angie-wmx \
 --net host \
 -e "TARANTOOL_MEMORY_GB=1" \
 -e "WALLARM_MODE=monitoring" \
 -e "WALLARM_API_HOST=api.wallarm.ru" \
 -e WALLARM_API_TOKEN \
 --entrypoint=/bin/bash \
 localhost/dmikhin/angie-wmx:latest
