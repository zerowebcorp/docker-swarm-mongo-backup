#!/usr/bin/env bash

HOST=`cat /etc/mongodb_host`
S3=`cat /etc/s3bucket`
USERNAME=`cat /run/secrets/username`
PASSWORD=`cat /run/secrets/password`

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
H=$(date +%H)
M=$(date +%M)
S=$(date +%S)
DIR="${YEAR}/${MONTH}/${DAY}/${H}/${M}"
/usr/bin/mongodump --host ${HOST} -u  ${USERNAME}  -p ${PASSWORD} --authenticationDatabase admin --gzip --out ${DIR}
/usr/local/bin/aws s3 sync ${DIR} s3://${S3}/${DIR}
rm -rf ${DIR}