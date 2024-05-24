# angie-wmx

This is example [docker image](https://hub.docker.com/r/dmikhin/angie-wmx) based on official
[docker.angie.software/angie:1.5.1](https://angie.software/installation/docker/)
stable image with [WMX module](https://webmonitorx.ru/) integrated for WAF protection.
For more details check:
* [Dockerfile](Dockerfile)
* [scripts/build.sh](scripts/build.sh)

Image can be executed with [run.sh](run.sh) script:
```PowerShell
$ NODE_TOKEN='<Your WMX Token>' ./run.sh
```
Send an example of a non-malicious request:
```HTML
$ curl 0
<!DOCTYPE html><html><head><script>window.onload=function(){window.location.href="/lander"}</script></head></html>
```
The request will be processed normally.
Send an example of a malicious request:
```HTML
$ curl 0/etc/passwd
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>Angie/1.5.1</center>
</body>
</html>
```
The request will be blocked. And displayed in the web interface: ![web ui](../media/web.png?raw=true)
Additional documentation can be found at [https://docs.webmonitorx.ru](https://docs.webmonitorx.ru).
