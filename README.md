# Golang API on k3d

⚠️ This repository is currently under development.

Automation implementing [Building a TODO API in Golang with Kuberetes](https://levelup.gitconnected.com/building-a-todo-api-in-golang-with-kubernetes-1ec593f85029) by [Alex Ellis](https://alexellisuk.medium.com/). Alex Ellis's article provides a great practical example of how to write a Go API and deploy it on Kubernetes. This repo is not meant to replace it, it is meant to expand on it from a DevOps perspective by automating the installation of dependencies, the k3d cluster, and the Go API.

I am creating this repository to teach myself the technologies used and to hopefully teach others who are just starting to learn DevOps and automation.

## Table of Contents
 1. Getting Started
     1. Tools and Technologies
         1. Docker
         2. Ansible
         3. k3d
         4. Golang
         5. OpenFaaS
         6. GitHub Actions
     2. Why this stack?
 1. Installing the Cluster
 2. Installing the App
 3. Uninstalling
