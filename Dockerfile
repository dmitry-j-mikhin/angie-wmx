FROM docker.angie.software/angie:1.8.1
ARG WMX_SOURCE="wallarm-4.6.50.x86_64.sh"

LABEL maintainer="Dmitry Mikhin <dmikhin@webmonitorx.ru>"

RUN --mount=type=bind,target=/tmp/build,source=.,ro \
    /usr/bin/env WMX_SOURCE=$WMX_SOURCE /tmp/build/scripts/build.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["angie", "-g", "daemon off;"]
