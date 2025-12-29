# Docker Installation Guide on Rocky Linux 9.7

> Production‑ready Docker CE installation for Rocky Linux 9.7

---

## ✅ Prerequisites
- Rocky Linux 9.7
- Root or sudo privileges

---

## 1️⃣ Remove Old Docker Versions
```bash
sudo dnf remove -y docker   docker-client docker-client-latest   docker-common docker-latest   docker-latest-logrotate docker-logrotate   docker-engine
```

---

## 2️⃣ Install Dependencies
```bash
sudo dnf install -y dnf-utils device-mapper-persistent-data lvm2
```

---

## 3️⃣ Add Docker Repository
```bash
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

---

## 4️⃣ Install Docker Engine
```bash
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

## 5️⃣ Enable and Start Docker
```bash
sudo systemctl enable --now docker
```

---

## 6️⃣ Verify Installation
```bash
docker version
docker run --rm hello-world
```

---

## 🔐 Run Docker Without sudo
```bash
sudo usermod -aG docker sadegh
newgrp docker
```

---

## ⚙️ Production Daemon Configuration
```bash
sudo mkdir -p /etc/docker
sudo nano /etc/docker/daemon.json
```

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  },
  "storage-driver": "overlay2",
  "exec-opts": ["native.cgroupdriver=systemd"]
}
```

```bash
sudo systemctl restart docker
```

---

## ✅ Done
Docker is now installed and ready on Rocky Linux 9.7.
