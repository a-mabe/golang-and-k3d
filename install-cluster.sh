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

message "Enter your password carefully, Ansible will not validate it." "warn"

ansible-playbook -vvv -i inventory.yaml main.yaml --ask-become-pass

# add_path ":/usr/local/go/bin"

# message
# message "Grabbing postgresql password..." "warn"
# message

# ## Grab the Postgresql password.
# ##
# postgres_password=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 --decode)

# ## Make sure the password exists.
# ##
# ## i.e., is not empty string.
# ##
# if [ "$postgres_password" != "" ]; then
#     message "Password successfully retrieved." "success"
# else
#     message "ERROR: Could not get password." "error"
#     message "Did postgresql install?" "alert"
#     exit
# fi

# message
# message "Creating todo table..." "warn"
# message

# while kubectl get pods -n default | grep -q "postgresql-client"; do
#     echo "..."
#     sleep 1
# done

# echo "CREATE TABLE todo ( \
# id INT GENERATED ALWAYS AS IDENTITY,\
# description text NOT NULL,\
# created_date timestamp NOT NULL,\
# completed_date timestamp NOT NULL);" | kubectl run postgresql-client --rm -i --restart='Never' --namespace default \
#         --image docker.io/bitnami/postgresql:11.6.0-debian-9-r0 --env="PGPASSWORD=$postgres_password" \
#         --command -- psql --host postgresql -U postgres -d postgres -p 5432

# message
# message "Table created." "success"
# message "Now forwarding OpenFaaS gateway" "warn"
# message


# kubectl rollout status -n openfaas deploy/gateway
# kubectl port-forward -n openfaas svc/gateway 8080:8080 &

# ## Need to check port forwarding worked here

# password=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
# echo -n $password | faas-cli login --username admin --password-stdin

# ## Pull the golang-middleware template.
# ##
# faas-cli template store pull golang-middleware

# message
# message "Clearing existing build and templated files..." "warn"
# message

# rm -rf todo
# rm -rf template
# rm -f todo.yml

## Scaffold an API.
##
# faas-cli new --lang $language --prefix $dockerhub_username $api_name

# faas-cli up -f todo.yml

# ## Install openfaas via arkade.
# ##
# arkade install openfaas

# prompt_for_password

# ## Install the cli.
# ##
# curl -SLsf https://cli.openfaas.com | echo $password | sudo sh -S -k

# ## Verify go templates can be reached.
# ##
# faas-cli template store list | grep -o go