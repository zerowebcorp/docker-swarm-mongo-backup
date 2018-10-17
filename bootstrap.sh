#!/bin/bash
chmod +x /cron.sh;
echo `printenv mongodb_host` > /etc/mongodb_host
echo `printenv s3bucket` > /etc/s3bucket
INTERVAL=`printenv cron_interval`
echo "${INTERVAL} /bin/bash /cron.sh" > /var/spool/cron/crontabs/root
echo " " >>/var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
chown root:crontab /var/spool/cron/crontabs/root
service cron start
tail -f /dev/null