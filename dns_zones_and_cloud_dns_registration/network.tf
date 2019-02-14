module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "0.5.0"
  project_id   = "${var.project_id}"
  network_name = "${local.network_name}"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    subnet-01 = []
  }
}
