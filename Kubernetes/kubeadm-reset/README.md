kubeadm reset

rm -rf $HOME/.kube/config

rm -rf /etc/cni/net.d

rm -rf /etc/kubernetes/manifests

rm -rf /etc/kubernetes/pki

rm -rf /etc/kubernetes/admin.conf

rm -rf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf

rm -rf /etc/kubernetes/controller-manager.conf

rm -rf /etc/kubernetes/scheduler.conf

ipvsadm --clear

iptables -P INPUT ACCEPT

iptables -P OUTPUT ACCEPT

iptables -P FORWARD ACCEPT

iptables -F

