install jenkins with :

1- https://www.jenkins.io/doc/book/installing/linux/

```
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk
sudo yum install jenkins
sudo systemctl daemon-reload
```
```
sudo systemctl enable --now  jenkins
sudo systemctl status  jenkins
```




2 and then :
```
cat /etc/passwd | grep jenkins

usermod -s /bin/bash jenkins

passwd jenkins

usermod -a -G root jenkins

service jenkins restart
```
```
visudo

%jenkins ALL=(ALL:ALL) NOPASSWD: ALL
```

```
ssh-keygen
ssh-copy-id jenkins@localhost
```
