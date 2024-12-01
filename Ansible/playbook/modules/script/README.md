```yaml
- name: Run a script on remote servers
  script: /path/to/local/script.sh
```


```
- name: Run a bash script on remote hosts
  script: /home/user/myscript.sh
  executable: /bin/bash
```
executable: نوع شل که برای اجرای اسکریپت استفاده می‌شود. به طور پیش‌فرض از /bin/sh استفاده می‌شود، اما می‌توانید شل‌های دیگر مانند /bin/bash یا /usr/bin/python را مشخص کنید.

در اینجا، اسکریپت با استفاده از شل bash اجرا می‌شود.



```
- name: Run a script only if the file doesn't exist
  script: /home/user/myscript.sh
  creates: /tmp/myfile.txt
```
در این مثال، اسکریپت فقط در صورتی اجرا می‌شود که فایل /tmp/myfile.txt وجود نداشته باشد.





