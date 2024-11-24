


![Uploading photo_5915608699488027436_y.jpg…]()



```

########################################Kubeclient :
Step 1: Create a User
$useradd ali
$passwd ali

Step 2: Generate user’s keys and certificates

mkdir /home/ali/.kube/
touch /home/ali/.kube/config
$cd /home/ali


########################################Master:
$openssl genrsa -out ali.key 2048

$openssl req -new -key ali.key -out ali.csr -subj "/CN=ali"

$openssl x509 -req -in ali.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out ali.crt -days 45


---------------------------------------------------
Step 3 and 4: Update the kubeconfig file
$kubectl config set-credentials ali --client-certificate=/home/ali/ali.crt --client-key=/home/ali/ali.key

$kubectl config set-context test --cluster=kubernetes --namespace=shahkar --user=ali

$kubectl config get-contexts

$kubectl --context=test get pods
We will fix the ‘forbidden’ error in step 5.

------------------------------------------------------

Step 5: Create RBAC objects
$create role and roleBinding

kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: shahkar  # Same namespace as the one in the context
  name: test
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"] # You can also use ["*"]


---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: test
  namespace: shahkar
subjects:
- kind: User      # Here we say it's a normal user and not a service account
  name: ali  # Here is where we define the user we created and defined in the context
  apiGroup: ""
roleRef:
  kind: Role
  name: test
  apiGroup: ""

---------------------------------------------------------
$cp /root/.kube/config root@lubeclientip:/home/ali/.kube/
cp ali.csr ali.crt ali.ky to /home/ali

copy to kubeclient

########################################kubeclient :
دقیقا همینا بمونه و بقیه پاک بشه
#edit config 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeU1ERXhOekUxTURjME5Gb1hEVE15TURFeE5URTFNRGMwTkZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTzRqCmtzVE1Cai8zV3dDNy8xcG9HVWJUTVVqRHpnQW5PcTd2dk02WURDNVI4Nzc1ZzZYdFhIUWZ5QUxFYmI1U25IQXUKU3p6ZlJSUkY0aWsybWg3dTMycnJFMjR6WFZYQjJhWnVlWisvRTlrVWliUUhDUS8ydjVzZ0lXeU9VaGpzTzliNwpoSEFDMU56M0xpOXdQTUkyQmt1NjNZc2s1elYzZC9heXhJamlieWJNa3R2Mmw5QUFicDBIdldsYkIwSDh2ZkFxCkRHRFNYYjBwSW5YOWZSV3NiWjRjU0RzVlNPSHdaVGNjVXN2SFFxL3NxSXdKS3RFMDVnd0ZsRGFwNks1bTVXL0MKbnQ1YWxWL0ZQSit6MDFlQzBETW9acHZYSHhwYXFDZkJrc2NxV3BsVEpYY3M1dGNCVmFVNG9pMFhmT2MyV3NoVwpDV1NGbFNDY2IrRGtwMi96dEowQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZQYjFBeExyMk5aZEJadjdBOXdveDVpbVJya3ZNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBQmhkMnlodXB5MXRjUkp4bGo4agpyakZoNk42ZmZNNEI2cnMxeEtldnZHdytDaEpRbFppN3FISktsYW1GK0NFQ3NOQkVmTEFEN29Oc24rZEEwVnJJCmJpM1NMNkxMakQ0N2prdUYvZkdOb01Gb3RGeE1uMWtYOTBEa08rMXVmYm1NczBycENwMHBqbkUxRXRTQ3dYOXQKd0RXUWF6QXRMREVOdUttSG4zMHphYkQwUVFQMEExRi9vcjZjUmM4UTZHeTNTNUlDYy83VTlGa1pidE42OW9pbgpWVzRBeEw2NGUvS0dwMmJRczhvZ2VSbFJCSkp2S1orSGc3NEcwUXhZdzBKQ1VpdGVaMmRic2dITXd0WUlCYVdRCmJWa215Y2tZNm1mWFl5QjZOZEVQK2lIdnRKSm9HbEJYYk81cFgzcjlaeWU3Z2l3ZEd5TTJ3Z3pEQlFhS2hKbnkKeG9RPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://192.85.85.47:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    namespace: shahkar
    user: ali
  name: test
current-context: test
kind: Config
preferences: {}
users:
- name: ali
  user:
    client-certificate: /home/ali/ali.crt
    client-key: /home/ali/ali.key


$chown -R ali /home/ali/


comment #export KUBECONFIG=/etc/kubernetes/admin.conf in bashrc



```




