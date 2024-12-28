# Renew Kubernetes Certificates on All Masters

## Steps to Follow on all Masters

1. Check the certificate expiration:
   ```bash
   kubeadm certs check-expiration
   ```

2. Create a directory for renewing certificates:
   ```bash
   mkdir /root/renew-cert
   ```

3. Change to the newly created directory:
   ```bash
   cd /root/renew-cert
   ```

4. Renew all certificates:
   ```bash
   kubeadm certs renew all
   ```

5. Copy the kube config to the home directory:
   ```bash
   cp /root/.kube/config /home/
   ```

6. Move Kubernetes manifests to the new directory:
   ```bash
   mv /etc/kubernetes/manifests/* /root/renew-cert/
   ```

7. Check the `crictl` pods:
   ```bash
   watch crictl pods
   ```

   **Note:** After using the `mv` command, the main pods should be removed from the list.  
   Once they are removed, use the `mv` command again to recreate the main pods.

8. Move the manifests back to their original location:
   ```bash
   mv /root/renew-cert/* /etc/kubernetes/manifests/
   ```

9. Check the `crictl` pods:
   ```bash
   watch crictl pods
   ```

10. Copy the admin configuration to the kube config:
   ```bash
   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   ```

11. Adjust the ownership of the kube config:
    ```bash
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    ```
