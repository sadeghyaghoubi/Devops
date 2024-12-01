هندلرها وظایفی هستند که تنها در صورت فراخوانی (trigger) از یک وظیفه دیگر اجرا می‌شوند. معمولاً برای عملیات‌هایی که نیاز به اجرای مجدد (مثل ری‌استارت سرویس‌ها) دارند، استفاده می‌شوند.

```
- name: Install nginx
  apt:
    name: nginx
    state: present
  notify:
    - restart nginx

handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted
```
وظیفه نصب nginx هندلر restart nginx را فراخوانی می‌کند.
هندلر تنها یک بار و در پایان پلی‌بوک اجرا می‌شود، حتی اگر چندین task آن را فراخوانی کنند.
