set -ex

docker run -it --rm \
 --name angie-wmx \
 --hostname angie-wmx \
 -e "TARANTOOL_MEMORY_GB=1" \
 -e "WALLARM_MODE=block" \
 -e "WALLARM_API_HOST=api.wallarm.ru" \
 -e WALLARM_API_TOKEN \
 -p 80:80 \
 dmikhin/angie-wmx:latest
