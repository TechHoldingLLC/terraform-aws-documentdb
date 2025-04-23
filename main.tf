########################
#  documentdb/main.tf  #
########################

###########
# Cluster
###########
resource "aws_docdb_cluster" "main" {
  cluster_identifier              = var.name
  master_username                 = var.master_username
  master_password                 = var.master_password
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  final_snapshot_identifier       = "${var.name}-final-snapshot"
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  storage_type                    = var.storage_type
  kms_key_id                      = data.aws_kms_alias.rds.target_key_arn
  port                            = var.db_port
  vpc_security_group_ids          = var.vpc_security_group_ids
  db_subnet_group_name            = aws_docdb_subnet_group.default.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.default.name
  engine                          = var.engine
  engine_version                  = var.engine_version
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  allow_major_version_upgrade     = var.allow_major_version_upgrade

  tags = {
    Name = var.name
  }
}

###########
# Instance
###########
resource "aws_docdb_cluster_instance" "main" {
  count = var.instance_count

  identifier                   = "${aws_docdb_cluster.main.id}-${count.index + 1}"
  cluster_identifier           = aws_docdb_cluster.main.id
  apply_immediately            = var.apply_immediately
  preferred_maintenance_window = var.preferred_maintenance_window
  instance_class               = var.instance_class
  engine                       = var.engine
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  enable_performance_insights  = var.enable_performance_insights
  ca_cert_identifier           = var.ca_cert_identifier

  tags = {
    Name = var.name
  }
}

###########
# Subnet Group
###########
resource "aws_docdb_subnet_group" "default" {
  name        = var.name
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.subnet_ids

  tags = {
    Name = var.name
  }
}

###########
# Parameter Group
###########
# https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html
resource "aws_docdb_cluster_parameter_group" "default" {
  name        = var.name
  description = "DB cluster parameter group"
  family      = var.cluster_family

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = {
    Name = var.name
  }
}
