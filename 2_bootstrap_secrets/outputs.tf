output "secretsmanager_kms_key_arn" {
  value = module.kms.secretsmanager_kms_key_arn
}

output "ssh_key_pair_name" {
  value = module.ssh.ssh_key_pair_name
}