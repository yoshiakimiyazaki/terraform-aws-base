#!/bin/bash
set -e
DIR=${1:-./}

echo "#--------------------------------------------------------------"
echo "# terraform fmt -recursive -check"
echo "#--------------------------------------------------------------"
terraform fmt -recursive -check
cd $DIR
echo "#--------------------------------------------------------------"
echo "# tflint ($PWD)"
echo "#--------------------------------------------------------------"
tflint
echo "#--------------------------------------------------------------"
echo "# terraform plan ($PWD)"
echo "#--------------------------------------------------------------"
terraform plan -lock=false
