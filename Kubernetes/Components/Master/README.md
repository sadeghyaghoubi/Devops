

# Kubernetes Master Node Components

Master Node in Kubernetes is responsible for managing the cluster and coordinating resources. Below are the main components of the Master Node along with simple explanations.

---

## 1. API Server (kube-apiserver)
- **Role**: The main interface for interacting with the cluster.
- **Explanation**: All requests via `kubectl` or other tools are sent to this component. It validates requests and forwards them to other cluster components.
- **Note**: This is the core communication hub for the cluster.

---

## 2. Controller Manager (kube-controller-manager)
- **Role**: Maintains the cluster state and ensures the actual state matches the desired state.
- **Explanation**: It contains various controllers, such as:
  - **Node Controller**: Monitors the status of nodes (active/inactive).
  - **Replication Controller**: Ensures the desired number of pods are running.
  - **Endpoint Controller**: Manages connections between services and pods.
- **Note**: Continuously monitors the state and takes necessary actions.

---

## 3. Scheduler (kube-scheduler)
- **Role**: Selects the best node for running new pods.
- **Explanation**: When a new pod is defined, the Scheduler decides which node to place it on based on available resources (CPU, RAM, etc.).
- **Note**: Factors like network traffic, resource usage, and configuration rules influence its decision.

---

## 4. etcd
- **Role**: Distributed database for storing the cluster state.
- **Explanation**: All cluster information (e.g., pod definitions, services, config maps) is stored in `etcd`.
- **Note**: The stability and availability of this database are critical for cluster functionality.

---


## Component Interactions

1. **API Server** acts as the central hub for communication between users and other components.
2. **Scheduler** and **Controller Manager** connect to the API Server and perform their tasks based on received data.
3. Cluster state data is stored in **etcd**, which all components rely on for reading and writing data.

---

