locals {
  environment        = lower(var.environment)
  region             = lower(var.region)
  short_region       = lower(var.region_short)
  product_name       = lower(var.product_name)
  product_owner      = lower(var.product_owner)
  server_name_prefix = local.environment == "nonprd" ? "npd" : "prd"
}

/* JENKINS CONTROLLER USER */

resource "aws_iam_user" "services_jenkins_controller_user" {
  name = "aws-${local.environment}-z-z-z-user-${local.product_name}-jenkinscontroller-z"

  tags = {
    Name = "aws-${local.environment}-z-z-z-user-${local.product_name}-jenkinscontroller-z"
    # Owner       = local.product_owner
    # Environment = local.environment
    # Product     = local.product_name
  }
}

data "aws_iam_policy_document" "services_jenkins_controller_policy" {
  statement {
    sid = "${local.product_name}JenkinsControllerPolicyEcr"

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:UploadLayerPart",
      "ecr:ListImages",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage"
    ]

    resources = [
      "arn:aws:ecr:${var.region}:${var.account_id}:repository/aws-${local.environment}-${local.short_region}-z-z-ecr-${local.product_name}-jenkinsagent-z",
      "arn:aws:ecr:${var.region}:${var.account_id}:repository/aws-${local.environment}-${local.short_region}-z-z-ecr-${local.product_name}-egressproxy-z"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }

  statement {
    sid = "${local.product_name}JenkinsControllerPolicyEcrAuth"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }


  statement {
    sid = "${local.product_name}JenkinsControllerPolicyEc2Describe"

    actions = [
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeInstances"
    ]

    resources = ["*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }

  statement {
    sid = "${local.product_name}tJenkinsControllerPolicyEc2Reboot"

    actions = [
      "ec2:RebootInstances"
    ]

    resources = ["arn:aws:ec2:*:${var.account_id}:instance/*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["aws-${local.environment}-${local.short_region}-*-*-ec2-${local.product_name}-${local.server_name_prefix}awsshdci-*"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }

  statement {
    sid = "${local.product_name}JenkinsControllerPolicyDynamoState"

    actions = [
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem"
    ]

    resources = ["arn:aws:dynamodb:${local.region}:${var.account_id}:table/aws-${local.environment}-${local.short_region}-z-z-dynamodb-${local.product_name}-terraformstate-z"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }

  statement {
    sid = "${local.product_name}JenkinsControllerPolicyS3StateRw"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]

    resources = ["arn:aws:s3:::aws-${local.environment}-${local.short_region}-z-z-s3-${local.product_name}-terraformstate-z/${local.product_name}_services_egress_proxy/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }


  statement {
    sid = "${local.product_name}JenkinsControllerPolicyS3StateList"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::aws-${local.environment}-${local.short_region}-z-z-s3-${local.product_name}-terraformstate-z"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.jenkins_controller_pub_cidr_blocks
    }
  }
}

resource "aws_iam_policy" "services_jenkins_controller_policy" {
  name        = "aws-${local.environment}-z-z-z-policy-${local.product_name}-jenkinscontroller-z"
  path        = "/"
  description = "Policy for on prem jenkins controller"

  policy = data.aws_iam_policy_document.services_jenkins_controller_policy.json

  tags = {
    Name = "aws-${local.environment}-z-z-z-policy-${local.product_name}-jenkinscontroller-z"
    # Owner       = local.product_owner
    # Environment = local.environment
    # Product     = local.product_name
  }
}

resource "aws_iam_user_policy_attachment" "services_jenkins_controller_policy_attach" {
  user       = aws_iam_user.services_jenkins_controller_user.name
  policy_arn = aws_iam_policy.services_jenkins_controller_policy.arn
}
