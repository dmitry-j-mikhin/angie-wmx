set -ex

F=wallarm-4.6.37.x86_64.sh
curl https://meganode.webmonitorx.ru/4.6/${F} -O
sh ./${F} -- -b --skip-registration --skip-systemd
rm ${F}

cat /tmp/build/conf/default.conf > /etc/angie/http.d/default.conf
cp /tmp/build/conf/proxy_params /etc/angie

sed -i -e 's|standalone|container|' /opt/wallarm/env.list

echo "
[program:registernode_loop]
command=/usr/local/bin/registernode_loop
autorestart=false
startsecs=0
redirect_stderr=true
stdout_logfile=/var/log/wallarm/registernode_loop-out.log
" >> /opt/wallarm/etc/supervisord.conf

mkdir -p /usr/local/bin
cp -a -v /tmp/build/scripts/registernode_* /usr/local/bin
cp -a -v /tmp/build/scripts/docker-entrypoint.sh /
