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
