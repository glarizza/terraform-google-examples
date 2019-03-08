output "project_id" {
  value       = "${module.host-project.project_id}"
  description = "The project ID of the shared VPC host project"
}

output "subnets_names" {
  value       = "${module.core-nonprod-network.subnets_names}"
  description = "The names of the subnets being created"
}

output "subnets_regions" {
  value       = "${module.core-nonprod-network.subnets_regions}"
  description = "The region where the subnets will be created"
}
