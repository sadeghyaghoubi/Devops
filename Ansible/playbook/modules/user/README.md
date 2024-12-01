برای ایجاد یا مدیریت کاربران.

```
- name: Add a new user
  hosts: all
  tasks:
    - name: Create a user
      user:
        name: testuser
        state: present
        shell: /bin/bash
```
