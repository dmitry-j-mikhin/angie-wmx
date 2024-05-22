set -ex

F=wallarm-4.6.27-test.x86_64.sh
F=wallarm-4.6.27.x86_64.sh
curl https://meganode.webmonitorx.ru/4.6/${F} -O
sh ./${F} -- -b --skip-registration --skip-systemd
rm ${F}

#uncomment echo module
sed -i \
    -e '/echo_module/s/^#//g' \
    /etc/angie/angie.conf
cat /tmp/build/default_addon.conf > /etc/angie/http.d/default.conf

cp -a -v /tmp/build/docker-entrypoint.sh /
