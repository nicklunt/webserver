resource "aws_security_group" "this" {
  count  = length(var.security_groups)
  name   = var.security_groups[count.index][0]
  vpc_id = var.security_groups[count.index][1]
}