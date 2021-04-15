#!/bin/bash
set -e
DIR=${1:-./}

echo "#--------------------------------------------------------------"
echo "# terraform fmt -recursive -check ($PWD)"
echo "#--------------------------------------------------------------"
terraform fmt -recursive -check
cd $DIR
echo "#--------------------------------------------------------------"
echo "# tflint ($PWD)"
echo "#--------------------------------------------------------------"
tflint
echo "#--------------------------------------------------------------"
echo "# tfsec ($PWD)"
echo "#--------------------------------------------------------------"
tfsec
