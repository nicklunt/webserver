# Introduction 
This is **TEMPLATE** project so **review/modify all values in all variables.tf files** before executing.

<br>

# Deployment
This project requires an **./env_var/\<env\>.backend.tfbackend** files. Those files created by step one (**1_bootstrap_tf_state**).

This project is to create the essential components for an application
* VPC
* Subnets
* etc

Allowed \<env\> **must** be one of the below
* dev
* qa
* uat
* prd

## Execution order example (for dev environment)
<br>

>   terraform init -backend-config=./env_vars/dev.backend.tfbackend
>   terraform validate
>   terraform plan
>   terraform apply
