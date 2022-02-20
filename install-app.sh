#!/usr/bin/env bash

# Copyright (C) Abigail Mabe - All Rights Reserved
#
# You may use, distribute, and modify this code under the terms of the license.
#
# A copy of the license should have been received with this code.
# If not, please email <mabe.abby.a@gmail.com>

set -a

. .env

## Add /usr/local/go/bin to the PATH if not already there.
##
add_path ":/usr/local/go/bin"

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
else
    message "ERROR: Could not get password." "error"
    message "Did postgresql install?" "alert"
    exit
fi

## Create the todo table.
##
echo "CREATE TABLE todo ( \
id INT GENERATED ALWAYS AS IDENTITY,\
description text NOT NULL,\
created_date timestamp NOT NULL,\
completed_date timestamp NOT NULL);" | kubectl run postgresql-client --rm -i --restart='Never' --namespace default \
        --image docker.io/bitnami/postgresql:11.6.0-debian-9-r0 --env="PGPASSWORD=$postgres_password" \
        --command -- psql --host postgresql -U postgres -d postgres -p 5432

message
message "Table created." "success"
message "Logging in to OpenFaaS CLI..." "warn"
message

message "Port-fowarding..." "success"

## Forward the OpenFaaS gateway UI.
##
# kubectl port-forward -n openfaas svc/gateway 8080:8080 &
kubectl port-forward -n openfaas svc/gateway 8080:8080 2>&1 >/dev/null &

message "Waiting for service to become available..." "warn"

# until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8080); do
#     echo '...'
#     sleep 1
# done

until curl -s -f -o /dev/null "http://127.0.0.1:8080"; do
    echo "..."
    sleep 1
done

message "Service can be reached." "success"
message "Grabbing password to login to OpenFaaS" "warn"
message

## Grab the OpenFaaS password.
##
openfaas_password=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)

if [ "$openfaas_password" != "" ]; then
    message "Password successfully retrieved." "success"
else
    message "ERROR: Could not get password." "error"
    message "Did OpenFaaS install?" "alert"
    exit
fi

# Use the password to login.
#
echo -n $openfaas_password | faas-cli login --username admin --password-stdin

message "Successfully logged in..." "success"

message "Pulling golang-middleware template..." "success"

## Pull the golang-middleware template.
##
faas-cli template store pull golang-middleware

## Scaffold an API.
##
faas-cli new --lang $language --prefix $dockerhub_username $api_name

## Replace contents of handler.go.
##
cp -f templates/handler.go.tpl todo/handler.go

export PATH=$PATH:/usr/local/go/bin

## Ensure file is formatted correctly.
##
gofmt -w -s ./todo/handler.go

faas-cli secret create username --from-literal $username
faas-cli secret create password --from-literal $postgres_password
faas-cli secret create host --from-literal $host

export GO111MODULE=on
cd todo

go mod init todo
go mod tidy
go get

cd ..

cp -f templates/todo.yml.tpl todo.yml

faas-cli up -f todo.yml --build-arg GO111MODULE=on
