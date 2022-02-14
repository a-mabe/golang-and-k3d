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
message "Terminating function..." "alert"
message

kubectl delete deploy todo -n openfaas-fn

message
message "Killing port-forward..." "alert"
message

pkill kubectl
