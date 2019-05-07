locals {
  network_name = "simple-regional-gke-example"
  subnet_name  = "primary-01"
}

module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "0.5.0"
  project_id   = "${module.gke-basic-project.project_id}"
  network_name = "${local.network_name}"

  subnets = [
    {
      subnet_name           = "${local.subnet_name}"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    "${local.subnet_name}" = [
      {
        range_name    = "${local.subnet_name}-pods"
        ip_cidr_range = "192.168.16.0/20"
      },
      {
        range_name    = "${local.subnet_name}-services"
        ip_cidr_range = "192.168.48.0/20"
      },
    ]
  }
}
