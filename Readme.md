# MongoDB Automated Backup using Docker Swarm container and upload to S3 Bucket

## Requirement
* Docker swarm cluster
* IAM role on the AWS instance that has access to the S3 Bucket to upload files


# Instruction to execute

```
echo "BackupUsername" | docker secret create mongo-backup-username -
echo "BackupPassword" | docker secret create mongo-backup-password -

docker service create --name mongo-backup \
--env mongodb_host="replica/127.0.0.1:27017,127.0.0.2:27017,127.0.0.3:27017" \
--env s3bucket="myS3BucketName" \
--env cron_interval="0,15,30,45 * * * *" \
--secret source=secret create mongo-backup-username,target=username \
--secret source=secret create mongo-backup-password,target=password \
--with-registry-auth \
--constraint "node.role != manager" \
--detach=true \
getvivekv/docker-swarm-mongo-backup
```