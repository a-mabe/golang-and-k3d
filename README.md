# Golang API on k3d

⚠️ This repository is currently under development.

Automation implementing [Building a TODO API in Golang with Kuberetes](https://levelup.gitconnected.com/building-a-todo-api-in-golang-with-kubernetes-1ec593f85029) by [Alex Ellis](https://alexellisuk.medium.com/). Alex Ellis's article provides a great practical example of how to write a Go API and deploy it on Kubernetes. This repo is not meant to replace it, it is meant to expand on it from a DevOps perspective by automating the installation of dependencies, the k3d cluster, and the Go API.

I am creating this repository to teach myself the technologies used and to hopefully teach others who are just starting to learn DevOps and automation.

It is assumed that you've at least heard of *some* of the technologies used, but you haven't necessarily used any them.

## Table of Contents
1. [Tools and Technologies](tools-and-technologies)
    1. [Docker](docker)
    2. [k3d](k3d)
    3. [Ansible](ansible)
    4. [Golang](golang)
    5. [OpenFaaS](openfaas)
    6. ~~GitHub Actions~~ TBD
 1. [Installing](installing)
 1. [Uninstalling](uninstalling)
 1. [References](references)

## Getting Started

### Tools and Technologies

**Why this tech stack?**

Aside from the tools shown in the [tutorial](https://levelup.gitconnected.com/building-a-todo-api-in-golang-with-kubernetes-1ec593f85029), I decided to use Ansible, Bash, and Make because:

1. I'm familiar with Bash.
2. I wanted to learn Ansible.

...so, don't mistake Ansible for being the only way.

#### Docker

This repo uses [Docker](https://www.docker.com/) since it is required for k3d. We won't get into creating containers or Dockerfiles ourselves, however, if you're new to Docker I encourage you to research it. The key takeaway is ***containerization***. Containerization is the packaging of software with all of its dependencies into a single executable that can run consistently on any system. To run the application that this repo builds, you will need Docker installed on your machine. If you're running Ubuntu, Docker will be installed automatically by Ansible when you build the code. On OSX, you will need to install Docker yourself. Instructions to come.

- [Why you should use Docker](https://www.geeksforgeeks.org/why-should-you-use-docker-7-major-reasons/)
- [The Role of Docker in DevOps](https://dev.to/kodekloud/the-role-of-docker-in-devops-1con#:~:text=Docker%2C%20when%20used%20with%20DevOps,and%20built%2Din%20service%20concepts.)

#### k3d

[k3d](https://k3d.io) is a lightweight wrapper to run [k3s](https://k3s.io/). Okay, so what is k3s? It's lightweight [Kubernetes](https://kubernetes.io/) (abbreviated k8s). Essentially, k3s is k8s with anything that didn't really need to be a part of the core installation removed. Anything removed can be added back through an add-on as needed. Coming back to k3d, it runs containerized k3s clusters. This means that when you're running k3d you are still running k3s, it's just that k3s is running in a container. So, since we're using k3d, you should be able to run this even if your computer is a toaster.

- https://www.civo.com/blog/k8s-vs-k3s

#### Ansible

As of writing this, I am relatively new to [Ansible](https://github.com/ansible/ansible). I could read an Ansible playbook, mostly understand it, and even edit it, but I couldn't write one myself from scratch. In short, Ansible is an automation system. It can handle configuration management, application deployment, network automation, and more. *I did not have to use Ansible to implement any of this.* I chose to use it because it works good for what I wanted to use it for and I wanted to learn it.

- https://www.ansible.com/
- https://opensource.com/resources/what-ansible

#### Golang

[Golang or Go](https://go.dev/) is a programming language designed by Google. At the time of writing I barely know Go, but I know that it's extremely popular. If you're in the same boat, I suggest you do what I did and do some reading.

- https://dev.to/pavanbelagatti/why-is-go-so-damn-popular-among-developers-2d6h
- https://stackoverflow.blog/2020/11/02/go-golang-learn-fast-programming-languages/

#### OpenFaaS

[Open Function-as-a-Service (OpenFaaS)](https://www.openfaas.com/) allows you to deploy functions to Kubernetes, or in our case, k3d. Function-as-a-Service is a serverless way of executing modular pieces of code. Think [AWS Lambda](https://aws.amazon.com/lambda/). OpenFaaS in particular is an opensource FaaS.

- https://www.redhat.com/en/topics/cloud-native-apps/what-is-faas#:~:text=Function%2Das%2Da%2DService%2C%20or%20FaaS%2C%20is,to%20maintain%20their%20own%20infrastructure.
- https://github.com/openfaas/faas

## Installing

```
make install
```

## Uninstalling

```
make uninstall
```

## References

- [ansible-tuto](https://github.com/leucos/ansible-tuto)
- [Building a TODO API in Golang with Kubernetes](https://levelup.gitconnected.com/building-a-todo-api-in-golang-with-kubernetes-1ec593f85029)
- [Docker on Ubuntu Ansible Playbook](https://github.com/do-community/ansible-playbooks/blob/master/docker_ubuntu1804/playbook.yml)
- [hands-on-DevOps-gen2](https://github.com/nemonik/hands-on-DevOps-gen2)
- [Help you DevOps, use Make](https://medium.com/@xobb/help-you-devops-use-make-aebedd33c40f)
