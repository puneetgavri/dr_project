#!/bin/sh

REGION=$1
ENV=$2

echo $REGION
echo $ENV

REMOTE_TFSTATE_BUCKET_NAME="drdemo-$REGION-remote-backend";
REMOTE_TFSTATE_LOCK_DYNAMODB_NAME="terraform-lock";

cat > tfstate.tf <<BACKENDCONFIG
terraform {
  backend "s3" {
    bucket               = "$REMOTE_TFSTATE_BUCKET_NAME"
    encrypt              = true
    key                  = "terraform.tfstate"
    region               = "$REGION"
    dynamodb_table       = "$REMOTE_TFSTATE_LOCK_DYNAMODB_NAME"
  }
}
BACKENDCONFIG
echo -e "\e[32mTerraform file generated\e[0m"

terraform init -reconfigure

terraform workspace new $ENV || true;    # Don't care if already exist

