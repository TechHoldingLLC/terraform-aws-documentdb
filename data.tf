########################
#  documentdb/data.tf  #
########################

data "aws_kms_alias" "rds" {
  name = var.kms_key_alias
}
