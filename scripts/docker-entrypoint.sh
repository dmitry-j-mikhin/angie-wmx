#!/bin/sh

set -e
if [ "$1" != "angie" ] && [ "$1" != "angie-debug" ]; then
  exec "$@"
fi

source /usr/local/bin/registernode_fn.sh

configure_nginx() {
  if [ -n "$NGINX_EXTERNAL_CONFIG" ]; then
     return 0
  fi

  [ -n "$NGINX_BACKEND" ] || return 0

  if [ "$NGINX_BACKEND" = "${NGINX_BACKEND#http://}" ] \
     && [ "$NGINX_BACKEND" = "${NGINX_BACKEND#https://}" ]
  then
    sed -i -e "s#proxy_pass .*#proxy_pass http://$NGINX_BACKEND;#" \
      /etc/angie/http.d/default.conf
  else
    sed -i -e "s#proxy_pass .*#proxy_pass $NGINX_BACKEND;#" \
      /etc/angie/http.d/default.conf
  fi

  if [ -n "$DISABLE_IPV6" ]; then
    sed  -i '/ipv6only/d' /etc/angie/http.d/default.conf
  fi

  if [ ! -z "$NGINX_PORT" ]; then
    sed  -i -r "s#(listen.+)80(.+)#\1$NGINX_PORT\2#" \
      /etc/angie/http.d/default.conf
    sed  -i -r "s#(listen.+)80(.+)#\1$NGINX_PORT\2#" \
      /etc/angie/http.d/default.conf
    sed  -i -r "s#http://127.0.0.8/wallarm-status#http://127.0.0.8:$NGINX_PORT/wallarm-status#" \
      /opt/wallarm/etc/collectd/wallarm-collectd.conf.d/nginx-wallarm.conf
  fi

  sed -i -e "s@# wallarm_mode .*@wallarm_mode ${WALLARM_MODE:-monitoring};@" \
    /etc/angie/http.d/default.conf

  if [ -n "$WALLARM_APPLICATION" ]; then
    sed -i -e "s|# wallarm_application .*|wallarm_application $WALLARM_APPLICATION;|" \
      /etc/angie/http.d/default.conf
  fi
}

if [ x"$WALLARM_FALLBACK" = x"false" ]
then
  set -e
fi

if [ "x${SLAB_ALLOC_ARENA}" = 'x' ]; then
  if [ -n "$TARANTOOL_MEMORY_GB" ]; then
    SLAB_ALLOC_ARENA=$TARANTOOL_MEMORY_GB
    mkdir -p /etc/wallarm-override/
    echo "SLAB_ALLOC_ARENA=$SLAB_ALLOC_ARENA" >> /etc/wallarm-override/env.list
  fi
fi

if [ -z "$WALLARM_API_TOKEN" ]; then
  if [ ! -f "/etc/wallarm/private.key" ]; then
    echo "ERROR: no WALLARM_API_TOKEN and no private key in /etc/wallarm/private.key" >&2
    exit 1
  fi
fi

#taken from https://unix.stackexchange.com/a/71511
{ register_node 2>&1 | tee /dev/fd/3 | grep -q 'Label "group" is required for this registration type' && exit; } 3>&1
configure_nginx

su -p -s /bin/sh wallarm -c "exec /opt/wallarm/supervisord.sh" >/dev/null 2>&1 &
echo "Waiting for Tarantool to be available at 127.0.0.1:3313"
while :
do
  nc -z 127.0.0.1 3313 && { echo "127.0.0.1:3313 is available"; break; }
  sleep 1
done
exec "$@"
