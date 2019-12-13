#!/usr/bin/env sh

if [ "${MODE}" = "Restore" ]; then
    #Downlaod and restore
    echo "Downloading zookeeper backup from remote object store"
    swift download ${OS_BUCKET_NAME} ${OS_OBJECT_NAME} -o zookeeper.backup.json 
    java -cp zoocreeper-1.0-SNAPSHOT.jar com.boundary.zoocreeper.Restore -z ${ZK_URL} -f zookeeper.backup.json
    echo "Restore Done!!"
else
    #Backup and Upload
    if [ -n "${TAG}" ]; then
        export TAG=".${TAG}"
    fi
    export pattern=`date +"%Y%m%d%H%M"`
    java -jar zoocreeper-1.0-SNAPSHOT.jar -z ${ZK_URL} -f zookeeper.backup.${pattern}${TAG}.json
    #Publish to Object Repo
    echo "Publishing zookeeper backup to remote object store"
    swift upload ${OS_BUCKET_NAME} zookeeper.backup.${pattern}${TAG}.json
    echo "Upload to Swift Done!!"
fi

#Wait for 10 minutes before container dies. Added for troubleshooting purpose
sleep 600
