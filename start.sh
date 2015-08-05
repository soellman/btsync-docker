#!/bin/sh

# magically renumber the nobody user
sed -i "s|nobody:x:65534:65534:|nobody:x:$USERID:$GROUPID:|" /etc/passwd
sed -i "s|nobody:x:65534:|nobody:x:$GROUPID:|" /etc/group

# provide a nice nobody
if [ ! -f /config/btsync.conf ]; then
cat << EOF > "/config/btsync.conf"
{
  "storage_path" : "/config/.sync",
  "listening_port" : 3369,
  "use_upnp" : false,
  "webui" :
  {
    "listen" : "0.0.0.0:8888",
    "login" : "admin",
    "password" : "password"
  }
}
EOF
fi

mkdir -p /config/.sync
chown -R nobody:nobody /config

exec gosu nobody:nobody \
  /opt/btsync/btsync --nodaemon --config /config/btsync.conf --log /config/btsync.log
