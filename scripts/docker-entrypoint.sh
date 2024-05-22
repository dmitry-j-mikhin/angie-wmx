#!/bin/sh

set -e
if [ -n "$WALLARM_MODE" ]; then
  sed -i -e "s|wallarm_mode monitoring|wallarm_mode $WALLARM_MODE|g" /etc/angie/http.d/default.conf
fi
if [ -n "$WALLARM_API_HOST" ]; then
  args="$args -H $WALLARM_API_HOST"
fi
if [ -n "$TARANTOOL_MEMORY_GB" ]; then
  mkdir -p /etc/wallarm-override/
  echo "SLAB_ALLOC_ARENA=$TARANTOOL_MEMORY_GB" >> /etc/wallarm-override/env.list
fi
chroot --userspec=wallarm:wallarm / /opt/wallarm/register-node $args
chroot --userspec=wallarm:wallarm / /opt/wallarm/supervisord.sh >/dev/null 2>&1 &
echo "Waiting for Tarantool to be available at 127.0.0.1:3313"
while :
do
  timeout 1 bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/3313' && { echo "127.0.0.1:3313 is available"; break; }
  sleep 1
done
exec "$@"
