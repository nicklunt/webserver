module "bootstrap-tf" {
  source = "./modules/bootstrap-tf"

  account_id    = var.env_vars[var.environment].account_id
  product_name  = var.env_vars[var.environment].product_name
  product_owner = var.env_vars[var.environment].product_owner
  environment   = var.environment
  region        = var.env_vars[var.environment].region
  region_short  = var.env_vars[var.environment].region_short
}

# Generate tfbackend file for 2_bootstrap_secrets
#
# region         = "us-east-1"
# dynamodb_table = "aws-dev-use1-z-z-dynamodb-templateproduct-terraformstate-z"
# bucket         = "aws-dev-use1-z-z-s3-templateproduct-terraformstate-z"
# key            = "bootstrap_secrets/terraform.tfstate"
# encrypt        = true

resource "local_file" "bootstrap_secrets_terraform_tfstate" {

  content = format("region = \"%s\"\ndynamodb_table = \"%s\"\nbucket = \"%s\"\nkey = \"%s\"\nencrypt = \"true\"",
    var.env_vars[var.environment].region,
    module.bootstrap-tf.state_dynamodb_table,
    module.bootstrap-tf.state_bucket_name,
    "${var.environment}-${var.env_vars[var.environment].product_name}-bootstrap_secrets/terraform.tfstate"
  )

  filename = "${path.module}/../2_bootstrap_secrets/env_vars/${var.environment}.backend.tfbackend"
}

# Generate tfbackend file for 3_bootstrap_infra
#
# region         = "us-east-1"
# dynamodb_table = "aws-dev-use1-z-z-dynamodb-templateproduct-terraformstate-z"
# bucket         = "aws-dev-use1-z-z-s3-templateproduct-terraformstate-z"
# key            = "bootstrap_infra/terraform.tfstate"
# encrypt        = true

resource "local_file" "bootstrap_product_terraform_tfstate" {

  content = format("region = \"%s\"\ndynamodb_table = \"%s\"\nbucket = \"%s\"\nkey = \"%s\"\nencrypt = \"true\"",
    var.env_vars[var.environment].region,
    module.bootstrap-tf.state_dynamodb_table,
    module.bootstrap-tf.state_bucket_name,
    "${var.environment}-${var.env_vars[var.environment].product_name}-bootstrap-infra/terraform.tfstate"
  )

  filename = "${path.module}/../3_bootstrap_infra/env_vars/${var.environment}.backend.tfbackend"
}

# Generate tfbackend file for 4_<product_name>
#
# region         = "us-east-1"
# dynamodb_table = "aws-dev-use1-z-z-dynamodb-templateproduct-terraformstate-z"
# bucket         = "aws-dev-use1-z-z-s3-templateproduct-terraformstate-z"
# key            = "bootstrap_<product_name>/terraform.tfstate"
# encrypt        = true

resource "local_file" "product_terraform_tfstate" {

  content = format("region = \"%s\"\ndynamodb_table = \"%s\"\nbucket = \"%s\"\nkey = \"%s\"\nencrypt = \"true\"",
    var.env_vars[var.environment].region,
    module.bootstrap-tf.state_dynamodb_table,
    module.bootstrap-tf.state_bucket_name,
    "${var.environment}-${var.env_vars[var.environment].product_name}-product/terraform.tfstate"
  )

  filename = "${path.module}/../4_${var.env_vars[var.environment].product_name}/env_vars/${var.environment}.backend.tfbackend"
}