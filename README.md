# Introduction 
This is **TEMPLATE** project so **review/modify all values in all globa_vars.tf files** before executing.

The root level global_vars.tf is symlinked to the 4 projects global_vars.tf. 
This is because all global vars are the same for each project. 
Updating the root level global_vars.tf will therefore update global_vars.tf for all projects.

<br>

# Deployment
This project requires an **./env_var/\<env\>.backend.tfbackend** files. Those files created by step one (**1_bootstrap_tf_state**).

Allowed \<env\> **must** be one of the below
* dev
* qa
* uat
* prd

## Step 1 - Initialize terrafrom state in s3 bucket and DynampDB.

>   cd 1_bootstrap_tf_state<br>
>   terraform init -var environment="dev"<br>
>   terraform validate<br>
>   terraform plan -var environment="dev"<br>
>   terraform apply -var environment="dev"<br>

## Step 2 - Set permissions for Jenkins, ssh breakglass keys, and kms.

>   cd ../2_bootstrap_secrets<br>
>   terraform init -backend-config=./env_vars/dev.backend.tfbackend -var environment="dev"<br>
>   terraform validate<br>
>   terraform plan -var environment="dev"<br>
>   terraform apply -var environment="dev"<br>

## Step 3 - Build product base infrastructure.

>   cd ../3_testproduct<br>
>   terraform init -backend-config=./env_vars/dev.backend.tfbackend<br>
>   terraform validate<br>
>   terraform plan -var environment="dev"<br>
>   terraform apply -var environment="dev"<br>

## Step 4 - Build product application

>   cd ../4_testproduct<br> # rename '4_testproduct' to '4_product_name' where product_name is defined in global_vars.tf
>   terraform init -backend-config=./env_vars/dev.backend.tfbackend<br>
>   terraform validate<br>
>   terraform plan -var environment="dev"<br>
>   terraform apply -var environment="dev"<br>

 <br>
 <br>

# Deleting this project from AWS

## Step 1 - destroy product

>   cd 3_testproduct<br>
>   terraform destroy -var environment="dev"<br>
>   rm -rf .terraform .terraform.lock.hcl<br>

## Step 2 - destroy secrets

>   cd ../2_bootstrap_secrets<br>
>   terraform destroy -var environment="dev"<br>
>   rm -rf .terraform .terraform.lock.hcl<br>

## Step 3 - destroy botstrap items

### Step 3.1 - destroy DynamoDB tables

>   cd ../1_bootstrap_tf_state<br>
>   terraform destroy -target=module.bootstrap-tf.aws_dynamodb_table.terraform_state_table -var environment="dev"

### Step 3.2 - destroy terraform state S3 bucket

The S3 state bucket is set with prevent_destroy = true for a reason so we do not automate 
its deletion and it has to be done from console.

* Go to AWS console -> S3 -> Buckets.
* Select prodict's bucket (aws-<env>-use1-z-z-s3-<product_name>-terraformstate-z).
* Click on Empty and follow instructions.*

* Go to AWS console -> S3 -> Buckets.
* Select prodict's bucket (aws-<env>-use1-z-z-s3-<product_name>-terraformstate-z).
* Click on Delete and follow instructions.

### Step 3.3 - cleanup

>   terraform destroy -var environment="dev"<br>
>   rm -rf .terraform .terraform.lock.hcl<br>
