وقتی میخوای به یک ماشینی متصل بشی تا یکسری دستوراتو اجرا کنی که نیاز به سطح دسترسی بالاتری دارن حتما باید با root یا sudoer وارد بشی 
درنتیجه باید رمزو تو فایل بدی
```
- name: اجرای وظایف با رمز عبور sudo
  hosts: all
  become: yes
  vars:
    ansible_sudo_pass: Aa123123
  tasks:
    - name: نصب بسته vim
      apt:
        name: vim
        state: present
```
و اینکار اصلا عاقلانه نیست
چراکه هرکی vim کنه فایلو رمزو متوجه میشه
درنتیجه
خود انسیبل راه حلی داره برای این مورد : ansible-vault

برای ایجاد فایل playbook با این شرط که اون فایل رمز داشته باشه باید از این دستور استفاده کنی :
ansible-vault  create اسمplaybook


وقتی فایلو میسازی ازت رمز میخواد
که با این رمز فایل اجرا میشه edit میشه و مشاهده میشه

برای اجرا کردنش باید از دستور زیر استفاده کرد
ansible-playbook اسمplaybook --ask-vault-pass
اینجوری قبل اجرا شدن رمزو میپرسه
میشه از دستور زیر هم استفاده کرد :
ansible-playbook اسمplaybook --vault-id @prompt
قبل اجرا شدن رمزو میپرسه

ولی میتونیم رمزمونو تو فایل بنویسیم و آدرس اون فایلو بدیم
ansible-playbook اسمplaybook --vault-id @password.txt
آدرس فایل باید بدیم


میشه یکار دیگه هم انجام داد
فقط قسمتی که برامون مهمه رو بیایم رمز گذاری کنیم : ansible_sudo_pass: Aa123123 
یعنی همه چیش مثل playbook عادی هستش فقط بجای رمز فایل encrypt میذاریم
vim اسمplaybook :

```
- name: اجرای وظایف با رمز عبور sudo
  hosts: all
  become: yes
  vars:
    ansible_sudo_pass: Aa123123
  tasks:
    - name: نصب بسته vim
      apt:
        name: vim
        state: present
```

ansible-vault encrypt_string 'Aa123123' --name 'ansible_sudo_pass'

اینو بزنیم اول میگه یک رمزی براش بذار و بعد یک خروجی میده که باید جایگزین این عبارت کنیم :ansible_sudo_pass: Aa123123


برای اجرای فایل هم از دستور زیر استفاده میکنیم :
ansible-playbook اسمplaybook --ask-vault-pass
