از register برای ذخیره خروجی یک وظیفه در یک متغیر استفاده می‌کنیم تا بتوانیم از آن در وظایف بعدی بهره ببریم.

مثال ساده:
ذخیره نام هاست و چاپ آن:
```
- name: Get hostname
  command: hostname
  register: hostname_output

- name: Print hostname
  debug:
    msg: "The hostname is {{ hostname_output.stdout }}"
```
وظیفه اول خروجی دستور hostname را در متغیر hostname_output ذخیره می‌کند.
وظیفه دوم آن را چاپ می‌کند.
