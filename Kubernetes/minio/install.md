```
wget https://dl.min.io/server/minio/release/linux-amd64/minio -O /usr/local/bin/minio
chmod +x /usr/local/bin/minio
useradd -r minio-user -s /sbin/nologin
mkdir -p /mnt/minio
chown minio-user:minio-user /mnt/minio
mkdir -p /etc/minio
echo "MINIO_ROOT_USER=admin" | sudo tee -a /etc/minio/minio.env
echo "MINIO_ROOT_PASSWORD=123m123M" | sudo tee -a /etc/minio/minio.env
echo "MINIO_VOLUMES=\"/mnt/minio\"" | sudo tee -a /etc/minio/minio.env
chown -R minio-user:minio-user /etc/minio

vim /etc/systemd/system/minio.service 
[Unit]
Description=MinIO Object Storage
After=network.target

[Service]
User=minio-user
Group=minio-user
ExecStart=/usr/local/bin/minio server --config-dir /etc/minio $MINIO_VOLUMES
EnvironmentFile=-/etc/minio/minio.env
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target

systemctl daemon-reload
systemctl enable --now minio
systemctl status minio
netstat -ntulp
```
Open a browser and go to:
```
http://your-server-ip:9000
```
