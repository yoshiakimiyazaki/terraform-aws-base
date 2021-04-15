#!/bin/bash
set -e
DIR=${1:-./}
echo "#--------------------------------------------------------------"
echo "# terraform fmt -recursive -check ($PWD)"
echo "#--------------------------------------------------------------"
terraform fmt -recursive -check
cd $DIR
echo "#--------------------------------------------------------------"
echo "# terraform init ($PWD)"
echo "#--------------------------------------------------------------"
terraform init
echo "#--------------------------------------------------------------"
echo "# tflint ($PWD)"
echo "#--------------------------------------------------------------"
tflint
echo "#--------------------------------------------------------------"
echo "# tfsec ($PWD)"
echo "#--------------------------------------------------------------"
tfsec
echo "#--------------------------------------------------------------"
echo "# terraform apply ($PWD)"
echo "#--------------------------------------------------------------"
terraform apply -auto-approve
