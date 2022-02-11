#!/usr/bin/env bash

# Copyright (C) Abigail Mabe - All Rights Reserved
#
# You may use, distribute, and modify this code under the terms of the license.
#
# A copy of the license should have been received with this code.
# If not, please email <mabe.abby.a@gmail.com>

set -a

. .env

message
message "Creating a new k3d cluster..." "warn"
message

## Create a new cluster with k3d
##
k3d cluster create

message "Done!" "success"

check_cluster_ready

echo $1

message
message "Installing Postgresql to the cluster through arkade" "warn"
message

## Install Postgresql using arkade.
##
arkade install postgresql

message
message "Grabbing postgresql password..." "warn"
message

## Grab the Postgresql password.
##
postgres_password=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 --decode)

## Make sure the password exists.
##
## i.e., is not empty string.
##
if [ "$postgres_password" != "" ]; then
    message "Password successfully retrieved." "success"
    message $postgres_password
else
    message "ERROR: Could not get password." "error"
    message "Did postgresql install?" "alert"
    exit
fi

message
message "You will need to paste the following when prompted:" "alert"
message
message "CREATE TABLE todo (" "special"
message "  id              INT GENERATED ALWAYS AS IDENTITY," "special"
message "  description     text NOT NULL," "special"
message "  created_date    timestamp NOT NULL," "special"
message "  completed_date  timestamp NOT NULL" "special"
message ");" "special"
message
message "Then, to view the table, type:" "alert"
message
message "\dt" "special"
message
message "Next, you can exit with:" "alert"
message
message "\q" "special"
message

## Run the postgresql-client
##
kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace default \
    --image docker.io/bitnami/postgresql:11.6.0-debian-9-r0 --env="PGPASSWORD=$postgres_password" \
    --command -- psql --host postgresql -U postgres -d postgres -p 5432

## Install openfaas via arkade.
##
arkade install openfaas

## Install the cli.
##
curl -SLsf https://cli.openfaas.com | sh

## Verify go templates can be reached.
##
faas-cli template store list | grep -o go