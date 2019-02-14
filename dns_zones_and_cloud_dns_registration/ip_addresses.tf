module "address" {
  source           = "terraform-google-modules/address/google"
  version          = "0.1.0"
  enable_cloud_dns = "true"
  subnetwork       = "${module.network.subnets_self_links[0]}"
  dns_project      = "${var.project_id}"
  dns_domain       = "${local.domain}"
  dns_managed_zone = "${local.forward_zone}"
  dns_reverse_zone = "${local.reverse_zone}"
  names            = "${local.ip_address_names}"
  dns_short_names  = "${local.dns_short_names}"
}
