# Network Module Outputs
output "subnets_names" {
  value       = "${module.network.subnets_names}"
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = "${module.network.subnets_ips}"
  description = "The IP and cidrs of the subnets being created"
}

output "subnets_regions" {
  value       = "${module.network.subnets_regions}"
  description = "The region where subnets will be created"
}

output "subnets_self_links" {
  value       = "${module.network.subnets_self_links}"
  description = "The self-links of subnets being created"
}

# Address Module Outputs
output "ip_addresses" {
  description = "List of IP address values managed by the address module (e.g. [\"1.2.3.4\"])"
  value       = "${module.address.addresses}"
}
