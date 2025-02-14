set -ex
TAG="4.6.52-1"
SHORT="4.6"

docker tag wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:$SHORT wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:$TAG
docker push wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:$TAG

docker push wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:$SHORT
