#!/bin/sh

set -e
if [ -n "$WALLARM_MODE" ]; then
  sed -i -e "s|wallarm_mode monitoring|wallarm_mode $WALLARM_MODE|g" /etc/angie/http.d/default.conf
fi
if [ -n "$WALLARM_API_HOST" ]; then
  args="$args -H $WALLARM_API_HOST"
fi
if [ -n "$TARANTOOL_MEMORY_GB" ]; then
  sed -i -e "s|SLAB_ALLOC_ARENA=0.2|SLAB_ALLOC_ARENA=$TARANTOOL_MEMORY_GB|g" /opt/wallarm/env.list
fi
/opt/wallarm/register-node $args
/opt/wallarm/supervisord.sh &
echo "Waiting for Tarantool to be available at 127.0.0.1:3313"
while :
do
  nc -z 127.0.0.1 3313 && { echo "127.0.0.1:3313 is available"; break; }
  sleep 1
done
exec "$@"
