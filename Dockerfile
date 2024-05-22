# syntax=docker/dockerfile:experimental
FROM docker.angie.software/angie:1.4.1-debian

LABEL maintainer="Dmitry Mikhin <dmikhin@webmonitorx.ru>"

RUN --mount=type=bind,target=/tmp/build,source=scripts,ro \
    /tmp/build/build.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["angie", "-g", "daemon off;"]
