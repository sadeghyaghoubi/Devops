# Kubernetes `spec` Guide

In Kubernetes, the **`spec`** section defines how a resource (e.g., Pod, Deployment, or Service) should behave. It specifies the desired state or configuration of the resource, which Kubernetes uses to create and manage it.

---

## **Why is `spec` important?**

1. **Defines Requirements:** Specifies how the resource should run or behave.
2. **Precise Configuration:** Includes details like replicas, container specifications, and resource requirements.
3. **Controls Behavior:** Dictates the behavior of resources (e.g., how a Service connects to Pods or how a Job executes).

---

## **General Structure of `spec`**

```yaml
apiVersion: v1
kind: ResourceType
metadata:
  name: resource-name
spec:
  key1: value1
  key2:
    - subkey1: value2
    - subkey2: value3


## **spec Subsections for Different Resources **
1. Pod
A Pod contains one or more containers running together.

spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
      resources:
        limits:
          cpu: "500m"
          memory: "128Mi"
        requests:
          cpu: "250m"
          memory: "64Mi"



containers: List of containers within the Pod.
image: Docker image for the container.
ports: Ports exposed by the container.
resources: Resource limits and requests (CPU and memory).
2. Deployment
Manages replicas and rolling updates for Pods.

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


replicas: Number of Pods to run.
selector: Identifies Pods managed by the Deployment.
template: Defines the Pod template created by the Deployment.


spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP

selector: Identifies Pods for the Service to route traffic to.
ports: Port mappings (external and internal).
type: Service type (ClusterIP, NodePort, LoadBalancer).

spec:
  template:
    spec:
      containers:
        - name: job-container
          image: busybox
          command: ["echo", "Hello, Kubernetes!"]
      restartPolicy: OnFailure
  backoffLimit: 4



template: Pod template for the Job.
restartPolicy: Policy for restarting Pods after failure.
backoffLimit: Number of retry attempts allowed.

spec:
  schedule: "*/5 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: cron-container
              image: busybox
              command: ["date"]
          restartPolicy: OnFailure

schedule: Cron schedule format.
jobTemplate: Defines the Job template executed by the CronJob.

spec:
  serviceName: "mysql"
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: mysql:5.7
          ports:
            - containerPort: 3306

serviceName: Name of the associated Service.
replicas: Number of Pod replicas.
selector: Identifies Pods managed by the StatefulSet.

spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi


accessModes: Access type (read/write).
resources: Requested storage size.

spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app
  minReplicas: 1
  maxReplicas: 10
  targetCPUUtilizationPercentage: 50


scaleTargetRef: Resource to scale.
minReplicas and maxReplicas: Minimum and maximum number of Pods.
targetCPUUtilizationPercentage: Desired CPU utilization.

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
        ports:
        - containerPort: 80





