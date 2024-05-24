set -ex

docker build --no-cache --pull \
 --tag dmikhin/angie-wmx:latest .
docker push dmikhin/angie-wmx:latest
