FROM docker.angie.software/angie:1.5.1

LABEL maintainer="Dmitry Mikhin <dmikhin@webmonitorx.ru>"

RUN --mount=type=bind,target=/tmp/build,source=.,ro \
    /tmp/build/scripts/build.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["angie", "-g", "daemon off;"]
