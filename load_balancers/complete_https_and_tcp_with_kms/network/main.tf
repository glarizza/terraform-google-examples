terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/complete_https_and_tcp_with_kms/network"
  }
}

locals {
  subnet_01    = "${local.network_name}-subnet-01"
  network_name = "lb-network"
}

# Network and subnetwork for all the infrastructure
module "network" {
  source       = "terraform-google-modules/network/google"
  project_id   = "${var.project_id}"
  network_name = "${local.network_name}"

  subnets = [
    {
      subnet_name   = "${local.subnet_01}"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "${var.region}"
    },
  ]

  secondary_ranges = {
    "${local.subnet_01}" = []
  }
}

# We need a NAT gateway to route traffic outbound so that Nginx can be
# downloaded and installed.
module "nat" {
  source     = "GoogleCloudPlatform/nat-gateway/google"
  region     = "${var.region}"
  network    = "${module.network.network_name}"
  subnetwork = "${module.network.subnets_self_links[0]}"
}
