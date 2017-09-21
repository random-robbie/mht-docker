#!/bin/bash

set -x

apt-get update 
apt-get upgrade -y 
apt-get install git wget gcc supervisor -y 
cd /opt/ 
git clone https://github.com/threatstream/mhn.git 
cd mhn

cat > /etc/supervisor/conf.d/mhntodocker.conf <<EOF
[program:mongod]
command=/usr/bin/mongod
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
autorestart=true
autostart=true

[program:nginx]
command=/usr/sbin/nginx
stdout_events_enabled=true
stderr_events_enabled=true
autostart=true
autorestart=true

EOF

mkdir -p /data/db /var/log/mhn /var/log/supervisor

supervisord &

#Starts the mongod service after installation
echo supervisorctl start mongod >> /opt/mhn/scripts/install_mongo.sh

./install.sh

supervisorctl restart all
