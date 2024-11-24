
ویژگی‌های emptyDir:

موقتی بودن داده‌ها:

داده‌ها فقط تا زمانی که پاد وجود دارد ذخیره می‌شوند. وقتی پاد حذف یا مجدداً راه‌اندازی شود، داده‌ها از بین می‌روند.

اشتراک‌گذاری بین کانتینرها:

اگر پاد شامل چندین کانتینر باشد، همه کانتینرها می‌توانند به داده‌های ذخیره‌شده در emptyDir دسترسی داشته باشند.

نوع ذخیره‌سازی:

داده‌ها معمولاً روی دیسک نود (سرور) ذخیره می‌شوند. اگر نود از حافظه کافی برخوردار باشد، Kubernetes ممکن است داده‌ها را در حافظه (RAM) نگهداری کند تا عملکرد افزایش یابد.



pod1-emptydir.yml
```

apiVersion: v1
kind: Pod
metadata:
  name: myboot-demo
spec:
  containers:
  - name: myboot-demo
    image: ---------
    volumeMounts:
      - name: myvol
        mountPath: /tmp/demo
  volumes:
    - name: myvol
      emptyDir: {}
	  
	  
#kubectl  apply  -f  pod1-emptydir.yml
#kubectl  exec  -it myboot-demo -- /bin/bash
# curl  localhost:8080/appendgreetingfil
```

