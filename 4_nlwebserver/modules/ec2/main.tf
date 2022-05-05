locals {
  #
  # "Standard"/"Global" variables
  #
  environment   = lower(var.environment)
  region        = lower(var.region)
  region_short  = lower(var.region_short)
  product_name  = lower(var.product_name)
  product_owner = lower(var.product_owner)

  #
  # module specific variables
  #

}

resource "aws_instance" "this" {
  ami                         = var.ami
  key_name                    = var.key_name
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id[0]
  #vpc_security_group_ids      = [aws_security_group.sg-vault.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 300
  }

  tags = {
    Name = local.product_name
  }
}