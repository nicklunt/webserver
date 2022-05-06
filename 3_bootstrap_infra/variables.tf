# variable "sg_vars" {
#   description = "Variables for security groups"

#   type = map(any)

#   default = {
#     "dev" = {
#       "sg_1" = {
#         sg_name = "aws-${local.environment}-${local.region_short}-z-z-sg-${local.product_name}-sg_1-z"
#       }
#       "sg_2" = {
#         sg_name = "aws-${local.environment}-${local.region_short}-z-z-vpc-${local.product_name}-sg_2-z"
#       }
#     }
#   }
# }

# variable "sg_rule_vars" {
#   description = "Variables for security group rules"

#   type = map(any)

#   default = {
#     "dev" = {
#       "sg_rule_1" = {
#         security_group = var.sg_vars[local.environment].sg_1.sg_name
#         sg_name        = "aws-${local.environment}-${local.region_short}-z-z-sgrule-${local.product_name}-sg_rule_1-z"

#       }
#       "sg_rule_2" = {
#         security_group = var.sg_vars[local.environment].sg_2.sg_name
#         sg_name        = "aws-${local.environment}-${local.region_short}-z-z-vpc-${local.product_name}-sg_rule_2-z"
#       }
#     }
#   }
# }