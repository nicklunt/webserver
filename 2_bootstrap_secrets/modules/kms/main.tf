locals {
  account_id    = lower(var.account_id)
  environment   = lower(var.environment)
  region        = lower(var.region)
  region_short  = lower(var.region_short)
  product_name  = lower(var.product_name)
  product_owner = lower(var.product_owner)
}

resource "aws_kms_key" "secretsmanager_kms_key" {
  description = "KMS key for secretsmanager encryption"
  is_enabled  = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "tf_key_policy",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${local.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
  ] })

  tags = {
    Product     = "${local.product_name}"
    Environment = "${local.environment}"
    Owner       = "${local.product_owner}"
  }

}

resource "aws_kms_alias" "secretsmanager_kms_key_alias" {
  name          = "alias/aws-${local.environment}-${local.region_short}-z-z-kms-${local.product_name}-secretsmanager-z"
  target_key_id = aws_kms_key.secretsmanager_kms_key.key_id
}
