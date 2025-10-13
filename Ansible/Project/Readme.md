
mkdir ansible-project

cd ansible-project

mkdir -p inventory playbooks roles/nginx/tasks

touch ansible.cfg inventory/hosts.ini playbooks/site.yml roles/nginx/tasks/main.yml

```
ansible-project/
├── ansible.cfg
├── inventory/
│   └── hosts.ini
├── playbooks/
│   └── site.yml
└── roles/
    └── nginx/
        └── tasks/
            └── main.yml
```



ansible.cfg:
```
[defaults]
inventory = inventory/hosts.ini
roles_path = roles
host_key_checking = False
```

inventory/hosts.ini :

```
[webservers]
web1 ansible_host=192.168.56.10 ansible_user=root
```

OR

```
[webservers]
localhost ansible_connection=local
```

playbooks/site.yml:

```
- name: Configure web servers
  hosts: webservers
  become: yes

  roles:
    - nginx
```

roles/nginx/tasks/main.yml
```
- name: Install nginx
  apt:
    name: nginx
    state: present
    update_cache: yes
  when: ansible_os_family == "Debian"

- name: Install nginx (RHEL)
  yum:
    name: nginx
    state: present
  when: ansible_os_family == "RedHat"

- name: Ensure nginx is running
  service:
    name: nginx
    state: started
    enabled: yes

- name: Create simple index.html
  copy:
    dest: /var/www/html/index.html
    content: |
      <h1>Hello from {{ inventory_hostname }}</h1>
```



run:
```
ansible-playbook playbooks/site.yml
```
