
You must be logged in to the server (Unauthorized) 


solution (on master1)
-------------------
openssl genrsa -out $USER.key 2048

sleep 1

openssl req -new -key $USER.key -subj "/CN=$USER/O=mohaymen" -out $USER.csr

sleep 1

openssl x509 -req -in $USER.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out $USER.crt -days 1000

sleep 1

kubectl config set-credentials $USER --client-certificate=$USER.crt --client-key=$USER.key --embed-certs=true --kubeconfig=$USER.kubeconfig


cp client-certificate and client-key from $USER.kubeconfig and replace client-certificate and client-key into /home/$USER/.kube.config in kubeclient
