# Golang API on k3d

⚠️ This repository is currently under development.

Automation implementing [Building a TODO API in Golang with Kuberetes](https://levelup.gitconnected.com/building-a-todo-api-in-golang-with-kubernetes-1ec593f85029) by [Alex Ellis](https://alexellisuk.medium.com/). Alex Ellis's article provides a great practical example of how to write a Go API and deploy it on Kubernetes. This repo is not meant to replace it, it is meant to expand on it from a DevOps perspective by automating the installation of dependencies, the k3d cluster, and the Go API.

I am creating this repository to teach myself the technologies used and to hopefully teach others who are just starting to learn DevOps and automation.

It is assumed that you've at least heard of *some* of the technologies used, but you haven't necessarily used any them.

## Table of Contents
 1. Getting Started
     1. Tools and Technologies
         1. Docker
         2. k3d
         3. Ansible
         4. Golang
         5. OpenFaaS
         6. GitHub Actions
     2. Why this stack?
 1. Installing the Cluster
 2. Installing the App
 3. Uninstalling
 4. Summary of Terms
 5. References

## Getting Started

**Why this tech stack?**

I chose to not only use popular tools that work well together, but also a blend of tools I am familiar with and ones that I don't know that well.

### Docker

This repo uses [Docker](https://www.docker.com/) for k3d. We won't get into creating containers or Dockerfiles ourselves. However, if you're new to Docker I encourage you to research it. The key takeaway is ***containerization***. Containerization is the packaging of software with all of its dependencies into a single executable that can run consistently on any system. To run the application that this repo builds, you will need Docker installed on your machine. If you're running Ubuntu, Docker will be installed automatically by Ansible when you build the code. On OSX, you will need to install Docker yourself. Instructions to come.

Relevant resources:
- [Why you should use Docker](https://www.geeksforgeeks.org/why-should-you-use-docker-7-major-reasons/)
- [The Role of Docker in DevOps](https://dev.to/kodekloud/the-role-of-docker-in-devops-1con#:~:text=Docker%2C%20when%20used%20with%20DevOps,and%20built%2Din%20service%20concepts.)

### k3d

[k3d](https://k3d.io) is a lightweight wrapper to run [k3s](https://k3s.io/). Okay, so what is k3s? It's lightweight [Kubernetes](https://kubernetes.io/) (abbreviated k8s). Essentially, k3s is k8s with extra stuff that didn't need to be a part of the core installation removed. Anything removed can be added back if needed through an add-on. Coming back to k3d, it runs containerized k3s clusters. This means that when you're running k3d you are also running k3s, it's just that k3s is running in a container.

Relevant resources:
- https://www.civo.com/blog/k8s-vs-k3s
