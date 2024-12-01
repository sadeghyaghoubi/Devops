```
vim /etc/ansible/hosts

[webservers]
web1.local
web2.local

[databases]
db1.local

[all_servers:children]
webservers
databases
```
