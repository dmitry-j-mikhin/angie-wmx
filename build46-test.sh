set -ex

docker build --no-cache --pull --build-arg WMX_SOURCE=wallarm-4.6.51-pre.x86_64.sh \
 --tag wmx-public.gitlab.yandexcloud.net:5050/wmx-public/container-images/meganode:46test .
