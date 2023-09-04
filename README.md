# angie-wmx

This is example [docker image](https://hub.docker.com/r/dmikhin/angie-wmx) based on official
[docker.angie.software/angie:1.2.0](https://angie.software/install/#docker)
stable image with [WMX module](https://webmonitorx.ru/) integrated for WAF protection.
For more details check:
* [Dockerfile](Dockerfile)
* [scripts/build.sh](scripts/build.sh)

Image can be executed with [run.sh](run.sh) script:
```Shell
$ WALLARM_API_TOKEN='<Your WMX Token>' ./run.sh
```
Send an example of a non-malicious request:
```Shell
$ curl 127.1
<!DOCTYPE html>
<html>
<head>
<title>Welcome to Angie!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to Angie!</h1>
<p>If you see this page, the Angie web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="https://angie.software/">angie.software</a>.</p>

<p><em>Thank you for using Angie.</em></p>
</body>
</html>
```
The request will be processed normally.
Send an example of a malicious request:
```Shell
$ curl 127.1/etc/passwd
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>Angie/1.2.0</center>
</body>
</html>
```
The request will be blocked. And displayed in the web interface: ![web ui](../media/web.png?raw=true)
Additional documentation can be found at [https://docs.webmonitorx.ru](https://docs.webmonitorx.ru).
