read -p " please enter USER: " USER
read -p " please enter NAMESPACE: " NS
mkdir $USER-directory
cd $USER-directory

openssl genrsa -out $USER.key 2048
sleep 1
openssl req -new -key $USER.key -subj "/CN=$USER/O=mohaymen" -out $USER.csr
sleep 1
openssl x509 -req -in $USER.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out $USER.crt -days 1000
sleep 1

kubectl config set-cluster kubernetes --certificate-authority=/etc/kubernetes/pki/ca.crt --embed-certs=true --server=https://192.168.59.40:6443 --kubeconfig=$USER.kubeconfig
sleep 1
kubectl config set-credentials $USER --client-certificate=$USER.crt --client-key=$USER.key --embed-certs=true --kubeconfig=$USER.kubeconfig
sleep 1
kubectl config set-context default --cluster=kubernetes --user=$USER --kubeconfig=$USER.kubeconfig
sleep 1
#kubectl create ns $NS
sleep 1
kubectl create rolebinding $USER-access -n $NS --clusterrole edit --user $USER
sleep 1

sed -i 's+current-context: ""+current-context: "default"+g' $USER.kubeconfig
sleep 1
sed -i '11i \ namespace: '"$NS"'' $USER.kubeconfig
echo "done"
