install jenkins with :

1- https://www.jenkins.io/doc/book/installing/linux/

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

%jenkins All=(ALL) NOPASSWD: ALL
```

```
ssh-keygen
ssh-copy-id jenkins@localhost
```
