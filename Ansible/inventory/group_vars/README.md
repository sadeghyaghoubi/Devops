```
groupvars-ansible/
├── ansible.cfg
├── group_vars/
│   ├── dbservers.yml
│   └── webservers.yml
├── inventory
├── playbooks/
│   └── site.yml
└── roles/
    └── nginx/
        ├── handlers/
        │   └── main.yml
        ├── tasks/
        │   └── main.yml
        └── templates/
            └── nginx.conf.j2
```
```
[webservers]
localhost ansible_connection=local

[dbservers]
localhost ansible_connection=local
```


تو groupvars میاد اسم هایی که تو inventory  گذاشتیمو تطبیق میده با فایل های داخل group_vars
و درواقع اینجوری تشخیص میده کدوم var برای کدوم هاست هست
