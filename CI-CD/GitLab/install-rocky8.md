install GitLab on RockyLinux 8



```
yum update -y 
yum upgrade -y 
```

## Install the Required Packages
```
dnf -y install curl vim policycoreutils python3-policycoreutils git
```

## Add the GitLab CE Repository on RockyLinux 8

vim /etc/yum.repos.d/gitlab_gitlab-ce.repo

```
[gitlab_gitlab-ce]
name=gitlab_gitlab-ce
baseurl=https://packages.gitlab.com/gitlab/gitlab-ce/el/8/$basearch
repo_gpgcheck=1
gpgcheck=1
enabled=1
gpgkey=https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
       https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey/gitlab-gitlab-ce-3D645A26AB9FBD22.pub.gpg
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[gitlab_gitlab-ce-source]
name=gitlab_gitlab-ce-source
baseurl=https://packages.gitlab.com/gitlab/gitlab-ce/el/8/SRPMS
repo_gpgcheck=1
gpgcheck=1
enabled=1
gpgkey=https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
       https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey/gitlab-gitlab-ce-3D645A26AB9FBD22.pub.gpg
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

```
```
dnf repolist
```

## Install the GitLab CE on RockyLinux 8

```
dnf install gitlab-ce -y
```

## Configure the GitLab CE on RockyLinux 8
vim /etc/gitlab/gitlab.rb
Note: Replace gitlab.example.com with your actual domain

```
external_url 'http://gitlab.example.com'
```

```
gitlab-ctl reconfigure
```
After done, check GitLab running status,
```
gitlab-ctl status
```



### You can start,stop GitLab using below command,

```
gitlab-ctl stop
gitlab-ctl start
```


## Access GitLab Web Console
You can access visit GitLab browser using the provided URL http://gitlab.example.com.
```
cat /etc/gitlab/initial_root_password
```
