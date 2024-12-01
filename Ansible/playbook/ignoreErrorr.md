گاهی اوقات می‌خواهید در صورت بروز خطا در یک وظیفه (task)، پلی‌بوک متوقف نشود و به اجرای وظایف بعدی ادامه دهد.

```
- name: Create a directory
  file:
    path: /tmp/testdir
    state: directory
  ignore_errors: yes
```
