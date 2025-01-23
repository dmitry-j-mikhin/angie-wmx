register_node() {
  args="--batch"

  if [ -n "${DEPLOY_FORCE}" ]; then
    args="$args --force"
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
