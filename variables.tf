#############################
#  documentdb/variables.tf  #
#############################

variable "name" {
  description = "DocumentDB name"
  type        = string
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the DocumentDB Naming Constraints"
  type        = string
}

variable "backup_retention_period" {
  description = "Backup retention period"
  type        = number
}

variable "db_port" {
  description = "DocumentDB port"
  type        = number
  default     = 27017
}

variable "engine" {
  description = "The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid values: `docdb`"
  type        = string
  default     = "docdb"
}

variable "engine_version" {
  description = "The version number of the database engine to use"
  type        = string
  default     = "5.0.0"
}

variable "kms_key_alias" {
  description = "The alias for the KMS encryption key. When specifying `kms_key_alias`, `storage_encrypted` needs to be set to `true`"
  type        = string
  default     = "alias/aws/rds"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "The storage type to associate with the DB cluster. Valid values: standard, iopt1"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "iopt1"], var.storage_type)
    error_message = "Error: storage_type value must be one of two options - 'standard' or 'iopt1'."
  }
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "A value that indicates whether the DB cluster has deletion protection enabled"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "preferred_backup_window" {
  description = "Daily time range during which the backups happen"
  type        = string
  default     = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: `ddd:hh24:mi-ddd:hh24:mi`."
  type        = string
  default     = "Mon:22:00-Mon:23:00"
}

variable "vpc_security_group_ids" {
  description = "VPC security groups for DocumentDB"
  type        = list(string)
  default     = []
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to cloudwatch. The following log types are supported: `audit`, `profiler`"
  default     = []
}

variable "allow_major_version_upgrade" {
  description = "Specifies whether major version upgrades are allowed. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster#allow_major_version_upgrade"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether any minor engine upgrades will be applied automatically to the DB instance during the maintenance window or not"
  type        = bool
  default     = true
}

variable "instance_class" {
  description = "The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs"
  type        = string
  default     = "db.t3.medium"
}

variable "instance_count" {
  description = "Number of DB instances to create in the cluster"
  type        = number
  default     = 1
}

variable "enable_performance_insights" {
  description = "Specifies whether to enable Performance Insights for the DB Instance."
  type        = bool
  default     = false
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of VPC subnet IDs to place DocumentDB instances in"
  type        = list(string)
  default     = []
}

variable "cluster_family" {
  description = "The family of the DocumentDB cluster parameter group. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html"
  type        = string
  default     = "docdb5.0"
}

variable "cluster_parameters" {
  description = "List of DB parameters to apply"
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default = []
}
