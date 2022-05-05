output "data_subnet_id" {
  value = aws_subnet.data[*].id
}

output "app_subnet_id" {
  value = aws_subnet.app[*].id
}

output "web_subnet_id" {
  value = aws_subnet.web[*].id
}

output "infra_subnet_id" {
  value = aws_subnet.infra[*].id
}