set -ex

[ -f ~/.tokens ] && source ~/.tokens
docker run -it --rm \
 --name angie-wmx \
 --hostname angie-wmx \
 --net host \
 -e "WALLARM_MODE=monitoring" \
 -e "WALLARM_API_HOST=api.wallarm.ru" \
 -e "WALLARM_API_TOKEN=${NODE_TOKEN}" \
 localhost/dmikhin/angie-wmx:latest
