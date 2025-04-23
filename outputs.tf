###########################
#  documentdb/outputs.tf  #
###########################

output "cluster_arn" {
  value       = aws_docdb_cluster.main.arn
  description = "Amazon Resource Name (ARN) of the cluster"
}

output "cluster_identifier" {
  value       = aws_docdb_cluster.main.cluster_identifier
  description = "Cluster Identifier"
}

output "master_username" {
  value       = aws_docdb_cluster.main.master_username
  description = "Username for the master DB user"
  sensitive   = true
}

output "master_password" {
  value       = aws_docdb_cluster.main.master_password
  description = "Password for the master DB user"
  sensitive   = true
}

output "endpoint" {
  value       = aws_docdb_cluster.main.endpoint
  description = "Endpoint of the DocumentDB cluster"
}

output "reader_endpoint" {
  value       = aws_docdb_cluster.main.reader_endpoint
  description = "A read-only endpoint of the DocumentDB cluster, automatically load-balanced across replicas"
}

output "instance_arns" {
  value = var.instance_count > 0 ? aws_docdb_cluster_instance.main.*.arn : null
}

output "port" {
  value = aws_docdb_cluster.main.port
}
