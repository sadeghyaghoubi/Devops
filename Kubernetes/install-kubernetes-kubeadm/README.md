# install-kubernetes-kubeadm
https://upcloud.com/community/tutorials/install-kubernetes-cluster-centos-8/


####Prerequisites######

####on all master and worker node####
Disable SELinux enforcement
Disable firewalld

##Enable transparent masquerading and facilitate Virtual Extensible LAN (VxLAN) traffic for communication between Kubernetes pods across the cluster.
$ modprobe br_netfilter

##Set bridged packets to traverse iptables rules.
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

###Then load the new rules.
sysctl --system

####Disable all memory swaps to increase performance.
$swapoff -a
#Find the line in /etc/fstab referring to swap, and comment it.






#####Installing containerd on Master and Worker nodes######

$dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
$ yum remove runc
$dnf install containerd.io  --nobest -y

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
$systemctl enable containerd
$systemctl start containerd

####Using the systemd cgroup driver

$containerd config default | sudo tee /etc/containerd/config.toml

##To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  ...
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
If you apply this change make sure to restart containerd again:
$sudo systemctl restart containerd

----------------------------------------------------------------------


####Installing Kubernetes on Master and Worker nodes#####

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


$dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
$systemctl enable kubelet
$systemctl start kubelet



####Change the  cgroup to systemd by editing the Docker service with the following command:
vim /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
add Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS $KUBELET_CGROUP_ARGS

--------------------------------------------------------
#########HAproxy config###########

frontend apiservers
        bind 192.85.85.47:6443
        mode tcp
        option  tcplog
        default_backend k8s_apiservers

#frontend ingress
#        bind *:443
#        mode tcp
#        option  tcplog
#        default_backend k8s_ingress

backend k8s_apiservers
        mode tcp
        option  tcplog
        option ssl-hello-chk
        option log-health-checks
        default-server inter 10s fall 2
        server master2.com 192.85.85.21:6443 check
        server cluster1-master-2 10.169.241.163:6443 check
        server cluster1-master-3 10.169.241.153:6443 check




----------------------------------------------------------------


#####Configuring Kubernetes on the Master node only#####

kubeadm config images pull
edit vim /etc/containerd/config.toml
    sandbox_image = "registry.k8s.io/pause:3.10"

#Configure kubeadm

$kubeadm init --pod-network-cidr 192.85.0.0/16 --cri-socket /run/containerd/containerd.sock --apiserver-advertise-address 192.85.85.21 --upload-certs --control-plane-endpoint="192.85.85.47:6443"
crictl config --set runtime-endpoint=unix:///run/containerd/containerd.sock --set image-endpoint=unix:///run/containerd/containerd.sock

$mkdir -p $HOME/.kube
$sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$sudo chown $(id -u):$(id -g) $HOME/.kube/config
$kubectl get nodes






#########Join second master ###########
kubeadm join 192.85.85.47:6443 --token 17mpib.mdtao1gwju6evsq0  --discovery-token-ca-cert-hash sha256:9e832da578a0c9e0c572d61d858eb16efc64700cbeb45fdd4960174932682963         --control-plane --certificate-key 4b9fa7e6157894e78bce8a7b2404ed0343f0b59e79d2c910660d374df5003c68


####### join worker to cluster kuber  #######
kubeadm join 192.85.85.47:6443 --token 17mpib.mdtao1gwju6evsq0 --discovery-token-ca-cert-hash sha256:9e832da578a0c9e0c572d61d858eb16efc64700cbeb45fdd4960174932682963

you will see the status of the k8-master is ‘NotReady’. This is because we are yet to deploy the overlay network for the cluster.
kubectl create -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml




###Installing Bash Completion:
# Installing bash completion on Linux
  ## If bash-completion is not installed on Linux, install the 'bash-completion' package
  ## via your distribution's package manager.
  ## Load the kubectl completion code for bash into the current shell
  source <(kubectl completion bash)
  ## Write bash completion code to a file and source it from .bash_profile
  kubectl completion bash > ~/.kube/completion.bash.inc
  printf "
  # kubectl shell completion
  source '$HOME/.kube/completion.bash.inc'
  " >> $HOME/.bash_profile
  source $HOME/.bash_profile








