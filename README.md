![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/plexpy

[Plexpy](https://github.com/drzoidberg33/plexpy/) Is a Python-based Plex Usage tracker, that is currently in active development. 

## Usage

```
docker create --name=plexpy -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -v <path to plexlogs>:/logs:ro -e PGID=<gid> -e PUID=<uid>  -p 8181:8181 linuxserver/plexpy
```

**Parameters**

* `-p 8181` - Port for webui
* `-v /etc/localhost` for timesync - *optional*
* `-v /config` Containes plexpy config and database
* `-v /logs` Map this to PLex Media servers log directory - bonus points for mapping RO
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it quassel-core /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.



## Updates

* Upgrade to the latest version simply `docker restart plexpy`.
* To monitor the logs of the container in realtime `docker logs -f plexpy`.



**Versions**

**16.07.2015:** Inital Release