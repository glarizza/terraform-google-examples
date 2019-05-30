output "subnets_self_links" {
  value       = "${module.network.subnets_self_links}"
  description = "List of self_links for all the subnetworks created"
}

output "network_name" {
  value       = "${module.network.network_name}"
  description = "The name of the VPC network created"
}

output "routing_tag_regional" {
  value       = "${module.nat.routing_tag_regional}"
  description = "The tag needed by instances to route traffic out through the NAT gateway"
}
