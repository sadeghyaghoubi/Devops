#You can also download the whole helm chart with every file use the below command
$helm fetch argo/argo-cd
#This command will download every file of the helm chart in a .tgz package, run the below command to extract the file
tar xvfz argo-cd-7.7.11.tgz
cd argo-cd
$helm install --values values.yaml argocd . --namespace argo



https://192.168.59.34:30080/applications
kubectl -n argo get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode ; echo
fZ-Lf3B5Wc5n7al5
and username = admin
