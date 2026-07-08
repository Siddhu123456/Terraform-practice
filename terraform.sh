#!/bin/bash

set -e

ACTION=$1

if [ -z "$ACTION" ]; then
    echo "Usage:"
    echo "./terraform.sh init"
    echo "./terraform.sh fmt"
    echo "./terraform.sh validate"
    echo "./terraform.sh plan"
    echo "./terraform.sh apply"
    echo "./terraform.sh destroy"
    echo "./terraform.sh all"
    exit 1
fi

case "$ACTION" in

init)
    echo "Initializing Terraform..."
    terraform init
    ;;

fmt)
    echo "Formatting Terraform code..."
    terraform fmt -recursive
    ;;

validate)
    echo "Validating Terraform configuration..."
    terraform validate
    ;;

plan)
    echo "Generating execution plan..."
    terraform plan -out=tfplan
    ;;

apply)
    echo "Applying Terraform..."
    terraform apply tfplan
    ;;

destroy)
    echo "Destroying Infrastructure..."
    terraform destroy -auto-approve
    ;;

all)
    echo "Running Complete Terraform Automation..."

    terraform fmt -recursive

    terraform init

    terraform validate

    terraform plan -out=tfplan

    terraform apply -auto-approve tfplan

    ;;

*)
    echo "Invalid Option!"
    ;;
esac