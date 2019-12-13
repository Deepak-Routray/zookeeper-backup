# Zookeeper Backups in Openstack swift

A Docker container that uses excellent work by @boundary (https://github.com/boundary/zoocreeper).

It takes backup of zookeeper data and upload the same to openstack swift.
It can be used in docker based environment e.g. kubernetes. 
Image can be used to setup cron job to backup zookeeper peridically and upload the same in openstack swift.
It can also be used to restore zookeeper data from openstack swift.

## Environmant variables to be passed to container

Variable | Required | Description
--- | --- | ---
`OS_AUTH_URL` | Yes | Openstack Authorization URL                                                      
`OS_USERNAME` | Yes | User name to authenticate against Openstack keystone
`OS_PASSWORD` | Yes | Password to authenticate against Openstack keystone
`OS_USER_DOMAIN_NAME` | Yes | Domain name of the user
`OS_PROJECT_ID` | Yes | Openstack project id                                                      
`OS_PROJECT_DOMAIN_NAME` | Yes | Domain name assigned to the project
`ST_AUTH_VERSION` | No | Openstack Authentication Version. Default is 3.
`OS_BUCKET_NAME` | Yes | Openstack swift container name where backups would be uploaded. This should be an existing container.
`ZK_URL` | Yes | Standard ZooKeeper connection string
`MODE` | No | Operation Mode. Can be 'Backup' or 'Restore'. Default is 'Backup'                                                    
`TAG` | No | Tag can be used to identify the backup file stored in swift. E.g. Can tag backup as Prod/Dev or v0.1.0 etc. Used only for 'Backup' mode.
`OS_OBJECT_NAME` | No | Openstack swift container object name from where data to be restored. Required only for 'Restore' mode.
