از ماژول mail برای ارسال ایمیل از طریق پلی‌بوک استفاده می‌شود.

```
- name: Send notification email
  mail:
    host: smtp.example.com
    port: 25
    to: admin@example.com
    subject: "Ansible Playbook Execution"
    body: "The playbook has completed successfully."
```
توضیح:

host: سرور SMTP.

to: آدرس گیرنده.

subject: عنوان ایمیل.

body: متن ایمیل.

نکته: برای ارسال ایمیل، سرور SMTP باید به درستی پیکربندی شود.

