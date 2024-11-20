
# Kubernetes `apiVersion` Guide

In Kubernetes, the **`apiVersion`** specifies the API version used to define and manage a resource. It tells Kubernetes how to process resources like Pod, Deployment, Service, etc.

---

## **Why is `apiVersion` important?**

1. **Defines Resource Behavior:** Each API version has specific features, structure, and behavior.
2. **Version Compatibility:** Older versions may not support newer features or might behave differently.
3. **Managing Evolution:** With new features added or deprecated, `apiVersion` ensures proper handling.

---

## **Structure of `apiVersion`**

`apiVersion` typically follows one of these formats:

1. **Core Version**
   For core resources like `Pod`, `Service`, `ConfigMap`:
   ```yaml
   apiVersion: v1
   ```

2. **Group/Version**
   For advanced resources like `Deployment`, `Ingress`, `StatefulSet`:
   ```yaml
   apiVersion: <group>/<version>
   ```

Example:
```yaml
apiVersion: apps/v1
```

---

## **Common Groups and Versions**

### **Core Group (`core`)**
- For fundamental resources in Kubernetes.
- Version: `v1`
- Resources:
  - `Pod`
  - `Service`
  - `ConfigMap`
  - `Secret`
  - `PersistentVolume` (PV)
  - `PersistentVolumeClaim` (PVC)
  - `Namespace`
  - `Node`
  - `ReplicationController`

### **Group: `apps`**
- For application management resources.
- Current stable version: `apps/v1`
- Resources:
  - `Deployment`
  - `StatefulSet`
  - `DaemonSet`
  - `ReplicaSet`

### **Group: `batch`**
- For job-related resources.
- Versions:
  - `batch/v1` (stable)
- Resources:
  - `Job`
  - `CronJob`

### **Group: `extensions`**
- Previously used for resources like `Ingress` and `DaemonSet`.
- Most resources have moved to other groups (`apps`, `networking.k8s.io`).
- Resources:
  - Formerly `Ingress`, now: `networking.k8s.io/v1`

### **Group: `networking.k8s.io`**
- For networking resources.
- Versions:
  - `networking.k8s.io/v1` (stable)
- Resources:
  - `Ingress`
  - `NetworkPolicy`

### **Group: `policy`**
- For security policies.
- Versions:
  - `policy/v1` (stable)
- Resources:
  - `PodDisruptionBudget`

### **Group: `rbac.authorization.k8s.io`**
- For role-based access control (RBAC).
- Versions:
  - `rbac.authorization.k8s.io/v1` (stable)
- Resources:
  - `Role`
  - `ClusterRole`
  - `RoleBinding`
  - `ClusterRoleBinding`

### **Group: `storage.k8s.io`**
- For storage management.
- Versions:
  - `storage.k8s.io/v1` (stable)
- Resources:
  - `StorageClass`
  - `VolumeAttachment`

### **Group: `autoscaling`**
- For autoscaling resources.
- Versions:
  - `autoscaling/v1` (stable)
  - `autoscaling/v2` and `autoscaling/v2beta2` (advanced)
- Resources:
  - `HorizontalPodAutoscaler` (HPA)

### **Group: `certificates.k8s.io`**
- For certificate management.
- Versions:
  - `certificates.k8s.io/v1` (stable)
- Resources:
  - `CertificateSigningRequest` (CSR)

---

## **Choosing the Right Version**

- Always use the stable version unless specific beta features are required.
- **API Version Types:**
  - **Alpha:** Experimental and subject to change. Avoid in production.
  - **Beta:** More stable but may still have changes.
  - **Stable:** Fully tested and production-ready.

---

## **Examples**

### 1. A Simple Pod:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
```

### 2. A Deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

### 3. A Service:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```
