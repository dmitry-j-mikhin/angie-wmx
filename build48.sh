set -ex
V=4.8.3-1

docker build --no-cache --pull \
 --tag wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:$V .
docker push wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:$V
