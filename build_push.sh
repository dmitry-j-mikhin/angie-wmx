set -ex

DOCKER_BUILDKIT=1 docker build --no-cache --pull \
 --tag localhost/dmikhin/angie-wmx:latest .
#docker push localhost/dmikhin/angie-wmx:latest
