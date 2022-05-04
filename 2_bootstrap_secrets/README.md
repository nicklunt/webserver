
# Introduction 
This step sets permissions for jenkins, initiates kms, and keys.

# Running this project
This project requires an ./env_vars/<env>.backend.tfbackend files. Those files created by step one (1_bootstrap_tf_state).

Allowed <env> `must` be one of dev/qa/uat/prd.

## ./env_vars/dev.backend.tfbackend file example
    ```
    region         = "us-east-1"
    bucket         = "aws-dev-use1-z-z-s3-templateproduct-terraformstate-z"
    key            = "bootstrap_secrets/terraform.tfstate"
    dynamodb_table = "aws-dev-use1-z-z-dynamodb-templateproduct-terraformstate-z"
    ```

## Execution order example

    `terraform init -backend-config=./env_vars/dev.backend.tfbackend`
    `terraform validate`
    `terraform plan`
    `terraform apply`

