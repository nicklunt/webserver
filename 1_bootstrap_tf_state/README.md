# Introduction

This project is to initializa terraform's state in S3 and DynamoDB for each environment.

This is **TEMPLATE** project so **review/modify all values in all variables.tf files** before executing.

This project will also create two tfbackend files:

    ../2_bootstrap_secrets/env_vars/<environment>.backend.tfbackend
    ../3_<product_name>/env_vars/<environment>.backend.tfbackend

## ./env_vars/<env>.backend.tfbackend file

The ./env_vars/<env>.backend.tfbackend file holds configuration of the s3 terraform state bucket and the DynamoDb terraform locking table and is **required ONLY for terraform init command**.

### ./env_vars/dev.backend.tfbackend file example
    
    region         = "us-east-1"
    bucket         = "aws-dev-use1-z-z-s3-templateproduct-terraformstate-z"
    key            = "bootstrap_secrets/terraform.tfstate"
    dynamodb_table = "aws-dev-use1-z-z-dynamodb-templateproduct-terraformstate-z"
    

This project should be executed **ONCE per environment** (dev/qa/uat/prd).

<br>

# Deployment.

>   terraform init
>   terraform validate
>   terraform plan -var environment=dev
>   terraform apply -var environment=dev

<br>

# Tracking

Fill below after run for each environment so others know that backend has been created.

ENV     APPLIED     BUCKET                                          DYNAMODB_TABLE
DEV     Y           aws-dev-use1-z-z-s3-templateproduct-terraformstate-z  aws-dev-use1-z-z-dynamodb-templateproduct-terraformstate-z     
QA
UAT
PROD

