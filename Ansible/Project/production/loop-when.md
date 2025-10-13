```
ansible-project/
├── inventory
├── playbook.yml
└── roles/
    └── base_packages/
        └── tasks/
            └── main.yml
```


inventory:
```
[ubuntu_servers]
192.168.1.10 ansible_user=ubuntu

[centos_servers]
192.168.1.20 ansible_user=centos
```


roles/base_packages/tasks/main.yml:
```
- name: Install common packages on Ubuntu
  apt:
    name: "{{ item }}"
    state: present
    update_cache: yes
  loop:
    - curl
    - git
    - htop
  when: ansible_facts['os_family'] == "Debian"
  become: yes

- name: Install common packages on CentOS
  yum:
    name: "{{ item }}"
    state: present
  loop:
    - curl
    - git
    - htop
  when: ansible_facts['os_family'] == "RedHat"
  become: yes

```


playbook.yml
```
- name: Install common base packages
  hosts: all
  become: yes
  roles:
    - base_packages
```

```
ansible-playbook -i inventory playbook.yml
```


اگر پکیج‌ها در چند جا تکرار می‌شن، بهتره اون لیست رو در group_vars یا defaults قرار بدی، مثلاً:


roles/base_packages/defaults/main.yml:
```
common_packages:
  - curl
  - git
  - htop
```

task:
```
loop: "{{ common_packages }}"
```

