
# تنظیمات Global، Local و System در Git

در Git، تنظیمات می‌توانند در سه سطح مختلف اعمال شوند: **global**، **local** و **system**. هر یک از این سطوح محدوده متفاوتی از تنظیمات را پوشش می‌دهند. در ادامه هر یک از این سطوح را با توضیحات و مثال‌ها بررسی می‌کنیم:

## 1. Global Configuration (تنظیمات سراسری)
- تنظیماتی که در سطح کاربر انجام می‌شوند و برای تمامی مخازن (repositories) موجود در آن سیستم کاربر معتبر هستند.
- فایل تنظیمات سراسری معمولاً در مسیر `~/.gitconfig` یا `C:\Users\YourName\.gitconfig` قرار دارد.
- مثال:
  ```sh
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```
- این دستورات نام و ایمیل کاربر را به صورت سراسری تنظیم می‌کنند.

## 2. Local Configuration (تنظیمات محلی)
- تنظیماتی که در سطح مخزن انجام می‌شوند و فقط برای آن مخزن خاص معتبر هستند.
- فایل تنظیمات محلی در دایرکتوری مخزن و در مسیر `.git/config` قرار دارد.
- مثال:
  ```sh
  git config --local user.name "Repo Specific Name"
  git config --local user.email "repo.specific@example.com"
  ```
- این دستورات نام و ایمیل کاربر را برای یک مخزن خاص تنظیم می‌کنند.

## 3. System Configuration (تنظیمات سیستم)
- تنظیماتی که در سطح سیستم انجام می‌شوند و برای تمامی کاربران و مخازن روی آن سیستم معتبر هستند.
- فایل تنظیمات سیستم معمولاً در مسیر `/etc/gitconfig` قرار دارد.
- مثال:
  ```sh
  sudo git config --system core.editor "nano"
  ```
- این دستور ویرایشگر پیش‌فرض را به `nano` برای تمام کاربران و مخازن روی آن سیستم تنظیم می‌کند.

## مثال جامع
فرض کنید شما می‌خواهید برای یک پروژه خاص نام و ایمیل متفاوتی تنظیم کنید، در حالی که نام و ایمیل سراسری شما متفاوت است.

### 1. تنظیمات سراسری:
```sh
git config --global user.name "Global Name"
git config --global user.email "global.email@example.com"
```

### 2. تنظیمات محلی:
```sh
cd /path/to/your/repo
git config --local user.name "Local Name"
git config --local user.email "local.email@example.com"
```

در این حالت، اگر در داخل مخزن خاص (`/path/to/your/repo`) باشید و یک commit انجام دهید، Git از نام و ایمیل محلی استفاده می‌کند. اما در دیگر مخازن، از نام و ایمیل سراسری استفاده خواهد شد.

با استفاده از این روش‌ها، می‌توانید تنظیمات Git را در سطوح مختلف مدیریت کنید و به هر سطحی از تنظیمات نیاز دارید، تنظیمات مربوطه را اعمال کنید.
