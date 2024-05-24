register_node() {
  args="--batch"

  WALLARM_API_USE_SSL="${WALLARM_API_USE_SSL:-true}"
  WALLARM_API_CA_VERIFY="${WALLARM_API_CA_VERIFY:-true}"

  if [ -n "${DEPLOY_FORCE}" ]; then
    args="$args --force"
  fi

  if [ -n "$WALLARM_API_HOST" ]; then
    args="$args -H $WALLARM_API_HOST"
  fi

  if [ -n "$WALLARM_API_PORT" ]; then
    args="$args -P $WALLARM_API_PORT"
  fi

  if [ x"$WALLARM_API_USE_SSL" = x"false" ] \
     || [ x"$WALLARM_API_USE_SSL" = x"False" ] \
     || [ x"$WALLARM_API_USE_SSL" = x"no" ]
  then
    args="$args --no-ssl"
  fi

  if [ x"$WALLARM_API_CA_VERIFY" = x"false" ] \
     || [ x"$WALLARM_API_CA_VERIFY" = x"False" ] \
     || [ x"$WALLARM_API_CA_VERIFY" = x"no" ]
  then
    args="$args --no-verify"
  fi

  if [ -e /etc/wallarm/node.yaml ] \
     && [ -s /etc/wallarm/node.yaml ]
  then
    echo "Node registartion skipped - node.yaml already exists"
  elif [ -n "$NODE_UUID" ] \
    && [ -n "$NODE_SECRET" ] \
    && [ -n "$WALLARM_API_TOKEN" ]
  then
    su -p -s /bin/sh wallarm -c "exec /opt/wallarm/register-node \
      $args \
        --uuid '$NODE_UUID'"
  else
    su -p -s /bin/sh wallarm -c "exec /opt/wallarm/register-node \
      $args"
  fi
}
