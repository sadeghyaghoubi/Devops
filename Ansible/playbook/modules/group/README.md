برای ایجاد یا مدیریت گروه‌ها.

```
- name: Create a new group
  hosts: all
  tasks:
    - name: Add a group
      group:
        name: testgroup
        state: present
```
