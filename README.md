[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: http://tautulli.com
[dockerfileurl]: https://github.com/linuxserver/docker-tautulli/blob/master/Dockerfile
[hub]: https://hub.docker.com/r/linuxserver/tautulli/



[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png?v=4&s=4000)][linuxserverurl]


## Contact information:-

| Type | Address/Details |
| :---: | --- |
| Discord | [Discord](https://discord.gg/YWrKVTn) |
| IRC | freenode at `#linuxserver.io` more information at:- [IRC][ircurl]
| Forum | [Linuserver.io forum][forumurl] |

&nbsp;
&nbsp;

The [LinuxServer.io][linuxserverurl] team brings you another image release featuring :-

 + regular and timely application updates
 + easy user mappings
 + custom base image with s6 overlay
 + weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 + security updates

# linuxserver/tautulli
[![](https://images.microbadger.com/badges/version/linuxserver/tautulli.svg)](https://microbadger.com/images/linuxserver/tautulli "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/tautulli.svg)](https://microbadger.com/images/linuxserver/tautulli "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/tautulli.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/tautulli.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-tautulli)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-tautulli/)

[![Dockerfile-link](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/Dockerfile-Link-green.png)][dockerfileurl]

[Tautulli][appurl] A python based web application for monitoring, analytics and notifications for Plex Media Server.

[![tautulli](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/tautulli-icon.png)][appurl]

&nbsp;

## Usage

```
docker create \
  --name=tautulli \
  -v <path to data>:/config \
  -v <path to plex logs>:/logs:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  -p 8181:8181 \
  linuxserver/tautulli
```

&nbsp;

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.



| Parameter | Function |
| :---: | --- |
| `-p 8181` | Port for webui |
| `-v /config` | Contains tautulli config and database |
| `-v /logs` | Map this to Plex log directory - recommended RO |
| `-e PGID` | for GroupID, see below for explanation |
| `-e PUID` | for UserID, see below for explanation |
| `-e TZ` | for setting timezone information, eg Europe/London |

&nbsp;

## User / Group Identifiers

Sometimes when using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and it will "just work" &trade;.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

&nbsp;

## Setting up the application
Access the webui at `<your-ip>:8181`, for more information check out [Tautulli][appurl].
In tautulli gui settings, under `Plex Media Server`, turn on `Show Advanced` and set the `Logs Folder` to `/logs`

&nbsp;

## Container access and information.

| Function | Command |
| :--- | :--- |
| Shell access (live container) | `docker exec -it tautulli /bin/bash` |
| Realtime container logs | `docker logs -f tautulli` |
| Container version | `docker inspect -f '{{ index .Config.Labels "build_version" }}' tautulli` |
| Image version |  `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/tautulli` |
| Dockerfile | [Dockerfile][dockerfileurl] |

&nbsp;

## Changelog

|  Date | Changes |
| :---: | --- |
| 26.01.19 | Add pipeline logic and multi arch. |
| 23.10.18 | Update plex logs info in readme. |
| 16.08.18 | Rebase to alpine 3.8. |
| 10.03.18 | Rebrand to tautulli. |
| 12.12.17 | Rebase to alpine 3.7. |
| 21.07.17 | Internal git pull instead of at runtime. |
| 12.07.17 | Add inspect commands to README, move to jenkins build and push. |
| 25.05.17 | Rebase to alpine 3.6. |
| 20.04.17 | Add pycryptodomex pip package. |
| 07.02.17 | Rebase to alpine 3.5. |
| 09.09.16 | Add layer badges to README. |
| 27.08.16 | Add badges to README. |
| 08.08.16 | Rebase to alpine linux. |
| 16.07.15 | Inital Release. |
