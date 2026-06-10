
# Docker Voting App with Kubernetes & ArgoCD

## Overview

This project demonstrates a complete cloud-native deployment of the Docker Voting Application using Kubernetes and ArgoCD. The application consists of multiple microservices deployed on a Kubernetes cluster and managed through GitOps practices with ArgoCD.

## Architecture

```text
                +----------------+
                |    ArgoCD      |
                |   GitOps CD    |
                +--------+-------+
                         |
                         v
                  Git Repository
                         |
                         v
+--------------------------------------------------+
|                Kubernetes Cluster                |
|                                                  |
|  +---------+      +---------+                    |
|  |  Vote   | ---> | Redis   |                    |
|  +---------+      +---------+                    |
|       |                                        |
|       v                                        |
|  +---------+      +---------+                   |
|  | Worker  | ---> | Postgres|                  |
|  +---------+      +---------+                   |
|                        |                        |
|                        v                        |
|                  +---------+                    |
|                  | Result  |                    |
|                  +---------+                    |
+--------------------------------------------------+
```

---

## Project Structure

```text
argocd-voting-app/
├── argocd
│   └── application.yaml
│
├── k8s
│   ├── namespace.yaml
│   ├── redis-deployment.yaml
│   ├── redis-service.yaml
│   ├── db-deployment.yaml
│   ├── db-service.yaml
│   ├── vote-deployment.yaml
│   ├── vote-service.yaml
│   ├── result-deployment.yaml
│   ├── result-service.yaml
│   └── worker-deployment.yaml
│
├── scripts
│   ├── build-images.sh
│   ├── load-images.sh
│   └── deploy.sh
│
└── README.md
```

---

## Components

### Vote Service

Provides the user interface where users can cast votes.

### Redis

Acts as a temporary data store for vote submissions.

### Worker

Processes votes from Redis and stores results in PostgreSQL.

### PostgreSQL Database

Stores persistent voting results.

### Result Service

Displays voting results to users.

### ArgoCD

Continuously synchronizes Kubernetes manifests from GitHub to the Kubernetes cluster.

---

## Prerequisites

* Docker
* Kubernetes Cluster
* kubectl
* Git
* ArgoCD
* GitHub Repository

---

## Installation

### Clone Repository

```bash
git clone https://github.com/anjalivgowda8/docker-voting.git
cd docker-voting
```

### Create Namespace

```bash
kubectl apply -f k8s/namespace.yaml
```

### Deploy Application

```bash
kubectl apply -f k8s/
```

Verify resources:

```bash
kubectl get all -n voting-app
```

---

## Install ArgoCD

Create ArgoCD namespace:

```bash
kubectl create namespace argocd
```

Install ArgoCD:

```bash
kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify installation:

```bash
kubectl get pods -n argocd
```

---

## Access ArgoCD UI

Port-forward ArgoCD server:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open:

```text
https://localhost:8080
```

Retrieve admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
echo
```

Login:

```text
Username: admin
Password: <retrieved-password>
```

---

## Deploy Application Using ArgoCD

Apply ArgoCD Application:

```bash
kubectl apply -f argocd/application.yaml
```

Verify:

```bash
kubectl get applications -n argocd
```

Check synchronization status:

```bash
kubectl describe application voting-app -n argocd
```

---

## Useful Commands

### View Pods

```bash
kubectl get pods -n voting-app
```

### View Services

```bash
kubectl get svc -n voting-app
```

### View Deployments

```bash
kubectl get deployments -n voting-app
```

### Check Logs

```bash
kubectl logs <pod-name> -n voting-app
```

### Delete Application

```bash
kubectl delete -f k8s/
```

---

## GitOps Workflow

```text
Developer
    |
    v
Git Push
    |
    v
GitHub Repository
    |
    v
ArgoCD Detects Changes
    |
    v
Kubernetes Cluster Updated
```

---

## Features

* Kubernetes-based deployment
* Multi-container microservices architecture
* GitOps workflow using ArgoCD
* Automated synchronization
* Self-healing deployments
* Namespace isolation
* Scalable architecture

---

## Author

**Anjali V Gowda**

GitHub: https://github.com/anjalivgowda8

LinkedIn: https://www.linkedin.com/in/anjali-v-gowda-15088b337/

