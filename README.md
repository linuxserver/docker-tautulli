This docker setup for my python-based script crawls pre-defined RSS feeds and outputs JD2-crawljobs

Fork of: linuxserver/plexpy

## Usage

```
docker create \ 
  --name=rsscrawler \
  -v /etc/localtime:/etc/localtime:ro \
  -v <path to script>:/config \
  -v <path to folderwatch>:/jd2:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  linuxserver/rsscrawler
```

**Parameters**

* `-p 8181` - Port for webui
* `-v /etc/localtime` for timesync
* `-v /config` Containes RSScrawler config and database
* `-v /jd2` Map this to your JDownloaders folderwatch location (that feature needs to be enabled!)
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it plexpy /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.



## Updates

* Upgrade to the latest version simply `docker restart rsscrawler`.
* To monitor the logs of the container in realtime `docker logs -f rsscrawler`.



## Versions

+ **16.03.2016:** Inital Release
