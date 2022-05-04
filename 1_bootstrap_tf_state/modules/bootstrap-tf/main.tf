locals {
  product_name  = lower(var.product_name)
  environment   = lower(var.environment)
  product_owner = lower(var.product_owner)
  region        = lower(var.region)
  region_short  = lower(var.region_short)
}

resource "aws_s3_account_public_access_block" "public_access_block" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "aws-${local.environment}-${local.region_short}-z-z-s3-${local.product_name}-terraformstate-z"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "aws-${local.environment}-${local.region_short}-z-z-s3-${local.product_name}-terraformstate-z"
    Product     = "${local.product_name}"
    Environment = "${local.environment}"
    Owner       = "${local.product_owner}"
  }
}


resource "aws_s3_bucket_public_access_block" "terraform_state_bucket_public_access" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state_table" {
  name           = "aws-${local.environment}-${local.region_short}-z-z-dynamodb-${local.product_name}-terraformstate-z"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "aws-${local.environment}-${local.region_short}-z-z-dynamodb-${local.product_name}-terraformstate-z"
    Product     = "${local.product_name}"
    Environment = "${local.environment}"
    Owner       = "${local.product_owner}"
  }
}

locals {
  deploy_roles = 0
}

resource "aws_iam_role" "services_jenkins_infra_deployment_role" {
  count = local.deploy_roles

  name               = "aws-${local.environment}-z-z-z-role-${local.product_name}-jenkinsinfradeployment-z"
  assume_role_policy = data.aws_iam_policy_document.services_jenkins_infra_deployment_assume_role_policy.json

  tags = {
    Name        = "aws-${local.environment}-z-z-z-role-${local.product_name}-jenkinsinfradeployment-z"
    Product     = "${local.product_name}"
    Environment = "${local.environment}"
    Owner       = "${local.product_owner}"
  }
}

data "aws_iam_policy_document" "services_jenkins_infra_deployment_role_document" {
  statement {
    sid = "${title(local.product_name)}${title(local.environment)}PolicyJenkinsInfraDeploymentGlobal"

    actions = [
      "iam:*",
      "s3:*",
      "dynamodb:*"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "services_jenkins_infra_deployment_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:role/aws-${local.environment}-z-z-z-role-${local.product_name}-jenkinsinfradeployment-z"]
    }
  }
}

resource "aws_iam_policy" "services_jenkins_infra_deployment_policy" {
  count = local.deploy_roles

  name        = "aws-${local.environment}-z-z-z-policy-${local.product_name}-jenkinsinfradeployment-z"
  description = "Policy for jenkins infra deployment"

  policy = data.aws_iam_policy_document.services_jenkins_infra_deployment_role_document.json
}

resource "aws_iam_role_policy_attachment" "services_jenkins_infra_deployment_role_attach" {
  count = local.deploy_roles

  role       = aws_iam_role.services_jenkins_infra_deployment_role[count.index].name
  policy_arn = aws_iam_policy.services_jenkins_infra_deployment_policy[count.index].arn
}

data "aws_caller_identity" "current" {}

