# Output variable definitions

output "state_dynamodb_table" {
  description = "state lock table"
  value       = aws_dynamodb_table.terraform_state_table.id
}

output "state_bucket_name" {
  description = "remote state bucket"
  value       = aws_s3_bucket.terraform_state_bucket.id
}

output "aws_caller_id" {
  description = "The AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}
