step1:
install minio 


step 2:
```
mkdir velero
cd velero/
```
####install velero-CLI####
```
wget https://github.com/vmware-tanzu/velero/releases/download/v1.15.2/velero-v1.15.2-linux-amd64.tar.gz
tar -xvzf velero-v1.15.2-linux-amd64.tar.gz
ll
cd velero-v1.15.2-linux-amd64/
mv velero /usr/local/bin/
velero version
```
Create a New Bucket and new user and create access from user to bucket (name : velero)

Set Public Policy for the Bucket

Click on the velero bucket.

Go to the Permissions tab.

Set the bucket policy to Public (or create a custom policy to allow Velero access).

Save the changes.

##########
```
cat <<EOF > credentials-velero
[default]
aws_access_key_id = velero
aws_secret_access_key = 123v123V
EOF
```
```
kubectl create namespace velero
```
```
velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.8.2     --bucket velero     --secret-file credentials-velero     --backup-location-config region=minio,s3ForcePathStyle=true,s3Url=http://192.168.59.36:9000     --namespace velero
```
```
kubectl get pod -n velero
```


## Check the Backup Storage Location
```
kubectl get backupstoragelocations -n velero
```

## Create a Backup of ns:kube-system
```
velero backup create kube-system-backup --include-namespaces kube-system --wait
```
## Verify the Backup
```
velero backup get
```
```
[root@master1 ~]# velero backup get
NAME                 STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
kube-system-backup   Completed   0        0          2025-02-24 02:49:44 -0500 EST   29d       default            <none>
```


## Restore the kube-system Backup (If Needed)

```
velero restore create --from-backup kube-system-backup
```
```
velero restore get
```

## Schedule Automatic Backups (Optional)

```
velero schedule create kube-system-daily --schedule "0 0 * * *" --include-namespaces kube-system
```
