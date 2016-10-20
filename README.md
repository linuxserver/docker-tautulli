[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/plexpy

[![](https://images.microbadger.com/badges/image/linuxserver/plexpy.svg)](http://microbadger.com/images/linuxserver/plexpy "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/plexpy.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/plexpy.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io-hub-built/linuxserver-plexpy)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io-hub-built/job/linuxserver-plexpy/)
[hub]: https://hub.docker.com/r/linuxserver/plexpy/

[Plexpy](https://github.com/drzoidberg33/plexpy/) Is a Python-based Plex Usage tracker, that is currently in active development.

[![plexpy](https://15254b2dcaab7f5478ab-24461f391e20b7336331d5789078af53.ssl.cf1.rackcdn.com/plex.vanillacommunity.com/editor/nt/f3vfwj7miknj.png)][plexpyurl]
[plexpyurl]: https://github.com/drzoidberg33/plexpy/

## Usage

```
docker create \ 
  --name=plexpy \
  -v <path to data>:/config \
  -v <path to plexlogs>:/logs:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  -p 8181:8181 \
  linuxserver/plexpy
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8181` - Port for webui
* `-v /config` Containes plexpy config and database
* `-v /logs` Map this to PLex Media servers log directory - bonus points for mapping RO
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it plexpy /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
Access the webui at `<your-ip>:8181`, for more information check out [Plexpy](https://github.com/drzoidberg33/plexpy)..

## Info

* To monitor the logs of the container in realtime `docker logs -f plexpy`.

## Versions

+ **09.09.16:** Add layer badges to README.
+ **27.08.16:** Add badges to README.
+ **08.08.16:** Rebase to alpine linux.
+ **16.07.15:** Inital Release.
