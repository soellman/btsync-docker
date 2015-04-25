#!/bin/sh

# magically renumber the default user
sed -i "s|default:x:1000:1000:|default:x:$USERID:$GROUPID:" /etc/passwd
sed -i "s|default:x:1000:|default:x:$GROUPID:" /etc/group

# provide a nice default
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
chown -R $USERID:$GROUPID /config

exec gosu $USERID:$GROUPID \
  /opt/btsync/btsync --nodaemon --config /config/btsync.conf --log /config/btsync.log
