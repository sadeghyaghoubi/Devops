بعد از نصب git , argo :
(نکته مهم اینه که حتما تو helm مربوط به آرگو یک hostAlias تعریف کنیم برای gitlab.example.com  و آی پی گیت لبو بهش بدیم و مرحله بعد insecure فعال میکنیم)

مرحله اول باید تو گیت یه پروژه بسازیم مثلا kasra :

بعد میریم تو گیت لب :

admin --> network --> outband request --> ip وورکر هارو باید بدیم تا allow کنه


مرحله بعد تو پروژه یک پوشه ای درست میکنیم (مثلا production)

مرحله بعد میایم helm اون پروژه ای که میخوایمو push میکنیم تو این پوشه ای که ساختیم . git clone -cp helm folder to git cloned folder- git add * - git commit - git push


مرحله بعد باید app داخل آرگومونو بسازیم : که من یک app.yaml درست کردم و کافیه قسمتای

name

repourl:http://آدرس git/root/اسم پروژه.git

path: اسم پوشه که تو اینجا میشه production

value file : اون فایلای اضافه helm مربوط به پروژه


```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kasra-argo
  namespace: argocd
spec:
  project: default
  source:
    repoURL: http://gitlab.example.com/root/اسم پروژه.git
    targetRevision: HEAD
    path: اسم پوشه که تو اینجا میشه production
    helm:
      valueFiles:
        - values.yaml
        - global-values.yaml
        - app-version.yaml
        - db-migration-values.yaml
        - db-migration-version.yaml
        - mic-extend-version.yaml
        - mic-extend.yaml
        - mic-version.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```




و در مرحله آخر باید webhook درست کنیم:

url: http://ip worker که آرگو اومده بالا : پورت/api/webhook


==========================================================================
برای private کردن پروژه :

مرحله اول میریم تو تنظیمات پروژه ای که ساختیم تو گیت لب و visibility شو به Private تغییرش میدیم .

مرحله بعد یک یوزری توی گیت لب میسازیم

یک توکنی توی token access  ایجاد میکنیم

دسترسی اون یوزر به اون پروژه ایجاد میشه

 بعد میریم تو وب آرگو تو قسمت لیست ریپازیتوری ها و edit میکنیم : یوزر نیم میشه یوزرنیممون پسوورد میشه توکنی که ایجاد کردیم . 
