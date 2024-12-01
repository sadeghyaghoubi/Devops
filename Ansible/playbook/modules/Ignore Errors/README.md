```
- name: Create a directory
  file:
    path: /tmp/testdir
    state: directory
  ignore_errors: yes
```
