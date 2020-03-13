output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = module.rds_cluster_aurora.this_rds_cluster_id
}

output "this_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.rds_cluster_aurora.this_rds_cluster_resource_id
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.rds_cluster_aurora.this_rds_cluster_endpoint
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.rds_cluster_aurora.this_rds_cluster_reader_endpoint
}

output "this_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.rds_cluster_aurora.this_rds_cluster_database_name
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = module.rds_cluster_aurora.this_rds_cluster_port
}

output "this_rds_cluster_master_username" {
  description = "The master username"
  value       = module.rds_cluster_aurora.this_rds_cluster_master_username
}

output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.rds_cluster_aurora.this_rds_cluster_instance_endpoints
}
