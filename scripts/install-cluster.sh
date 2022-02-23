#!/usr/bin/env bash

# Copyright (C) Abigail Mabe - All Rights Reserved
#
# You may use, distribute, and modify this code under the terms of the license.
#
# A copy of the license should have been received with this code.
# If not, please email <mabe.abby.a@gmail.com>

set -e
set -a

. .env

cd ansible

message "Installing Ansible roles..." "notify"

ansible-galaxy install githubixx.kubectl

ansible-galaxy install fubarhouse.golang

message "Enter your password carefully, Ansible will not validate it." "warn"

ansible-playbook -vvv -i inventory.yaml main.yaml --ask-become-pass
