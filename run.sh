#!/bin/bash
set -x
set -e
python3 testConnection.py
source mystage.env

(cd terraform & \
  terraform init & \
  terraform plan \
    -var "trust_relationship__conditions__externalid=${AWS_EXTERNAL_ID}" \
    -var "trust_relationship__trusted_entities=${SNOWFLAKE_IAM_USER}" \
    --var "arn_bucket=arn:aws::s3:mynewsuperbucket")
