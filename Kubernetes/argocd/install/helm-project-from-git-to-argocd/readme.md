بعد از نصب git , argo :

مرحله اول باید تو گیت یه پروژه بسازیم مثلا kasra :

مرحله بعد تو پروژه یک پوشه ای درست میکنیم (مثلا production)

مرحله بعد میایم helm اون پروژه ای که میخوایمو push میکنیم تو این پوشه ای که ساختیم . git clone - git add * - git commit - git push


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
    repoURL: http://آدرس git/root/اسم پروژه.git
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


مرحله بعد میریم تو گیت لب :

admin --> network --> outband request --> ip وورکر هارو باید بدیم تا بلاک نکنه


و در مرحله آخر باید webhook درست کنیم:

url: http://ip worker که آرگو اومده بالا : پورت/api/webhook
