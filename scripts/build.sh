set -ex

F=wallarm-4.6.14.x86_64-musl.sh
curl https://meganode.webmonitorx.ru/4.6/${F} -O
sh ./${F} -- -b --skip-registration --skip-systemd
rm ${F}

sed -i \
 -e 's|listen.*|listen 8080;|g' \
 /etc/angie/http.d/default.conf
cat /tmp/build/default_addon.conf >> /etc/angie/http.d/default.conf

cp -a -v /tmp/build/docker-entrypoint.sh /
