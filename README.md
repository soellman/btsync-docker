# docker-btsync

Dockerized BTSync (2.0) that doesn't suck.

### What is it

Dockerized [BitTorrent Sync](http://www.bittorrent.com/sync/).

It's tiny- based on `progrium/busybox` and can run as any uid/gid you wish.

The default login and password is `admin` and `password`. Please change in `/config/btsync.conf`.

### Run it like this

```
docker run -d --name btsync \
  -e USERID=1337 \
  -e GROUPID=1337 \
  -p 3369:3369 \
  -p 3369:3369/udp \
  -p 8888:8888 \
  -v /myconfig:/config \
  -v /mydata:/sync \
  -v /etc/localtime:/etc/localtime:ro \
  soellman/btsync-docker
```

### Env vars

#### `USERID`
default 1000

#### `GROUPID`
default 1000

### Volumes

##### `/config`

Config files, state, and log.

##### `/sync`

btsync has access to this mount.

### Ports

#### 3369
sync tcp

#### 3369/udp
sync udp

#### 8888
webui

