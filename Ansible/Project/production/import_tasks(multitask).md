می‌خوای یک role بسازی به نام webserver که این کارها رو انجام بده:


چند پکیج لازم (مثل nginx, unzip) رو نصب کنه.


یک فایل HTML رو از templates/ کپی کنه.


سرویس Nginx رو enable و start کنه.


اگر فایل HTML تغییر کرد → Nginx restart بشه.


Taskها تمیز و قابل مدیریت باشن (با استفاده از include_tasks تقسیم‌شده به چند فایل).


```
ansible-project/
├── inventory
├── playbook.yml
└── roles/
    └── webserver/
        ├── tasks/
        │   ├── main.yml
        │   ├── install.yml
        │   ├── configure.yml
        │   └── service.yml
        ├── templates/
        │   └── index.html.j2
        └── handlers/
            └── main.yml
```

roles/webserver/tasks/main.yml:

```
- name: Install required packages
  import_tasks: install.yml

- name: Configure nginx
  import_tasks: configure.yml

- name: Manage nginx service
  import_tasks: service.yml
```

roles/webserver/tasks/install.yml:
```
- name: Install required packages
  apt:
    name: "{{ item }}"
    state: present
    update_cache: yes
  loop:
    - nginx
    - unzip
  become: yes
```

roles/webserver/tasks/configure.yml:
```
- name: Deploy custom index page
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
  notify: Restart nginx
  become: yes
```


roles/webserver/tasks/service.yml:
```
- name: Ensure nginx is enabled and started
  service:
    name: nginx
    state: started
    enabled: yes
  become: yes
```

roles/webserver/handlers/main.yml:
```
roles/webserver/handlers/main.yml
```


roles/webserver/templates/index.html.j2:
```
<html>
  <head><title>Welcome to {{ inventory_hostname }}</title></head>
  <body>
    <h1>Hello from {{ ansible_facts['os_family'] }} server!</h1>
    <p>Deployed at {{ ansible_date_time.date }} {{ ansible_date_time.time }}</p>
  </body>
</html>
```

playbook.yml:
```
- name: Setup full web server
  hosts: all
  become: yes
  roles:
    - webserver
```

```
ansible-playbook -i inventory playbook.yml
```
