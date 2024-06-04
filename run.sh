set -ex

[ -f ~/.tokens ] && source ~/.tokens
docker run -it --rm \
 --name angie-wmx \
 --hostname angie-wmx \
 -e "TARANTOOL_MEMORY_GB=0.3" \
 -e "WALLARM_MODE=block" \
 -e "NGINX_BACKEND=dvwa.org" \
 -e "WALLARM_API_HOST=api.wallarm.ru" \
 -e "WALLARM_API_TOKEN=${NODE_TOKEN}" \
 -p 80:80 \
 wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:latest "$@"
