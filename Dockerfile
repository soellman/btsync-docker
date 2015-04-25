FROM progrium/busybox
MAINTAINER Oliver Soell <oliver@soell.net>

# use progrium/busybox since it supports glibc

RUN opkg-install ca-certificates curl tar && \
    curl -o /usr/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && \
    chmod +x /usr/bin/gosu && \
    mkdir -p /opt/btsync && \
    curl -s -k -L "https://download-cdn.getsyncapp.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz" | tar -xzf - -C /opt/btsync && \
    opkg-cl remove ca-certificates curl tar && \
    rm -rf /var/opkg-lists

ADD /start.sh /start.sh

ENV USERID 1000
ENV GROUPID 1000

EXPOSE 3369 3369/udp 8888

VOLUME /config
VOLUME /sync

CMD ["/start.sh"]
