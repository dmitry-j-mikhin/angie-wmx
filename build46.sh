set -ex

docker build --no-cache --pull \
 --tag wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:4.6.48-1 .
docker push wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:4.6.48-1
