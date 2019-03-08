locals {
  region       = "us-west1"
  network_name = "shared-vpc-nonprod"
}

module "core-nonprod-network" {
  source          = "terraform-google-modules/network/google"
  version         = "0.6.0"
  project_id      = "${module.host-project.project_id}"
  network_name    = "${local.network_name}"
  shared_vpc_host = "true"

  # NOTE: The order of the subnets is VERY important and must be preserved.
  #       When needing to add new subnets, ALWAYS append to the end of the array of
  #       hashes below - NEVER prepend or insert an element in the middle. Doing so and
  #       disrupting the order of the existing subnets will cause Terraform to destroy
  #       and recreate the subnets.
  subnets = [
    {
      subnet_name           = "subnet-core-00"
      subnet_ip             = "10.13.0.0/24"
      subnet_region         = "${local.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "subnet-core-01"
      subnet_ip             = "10.13.1.0/24"
      subnet_region         = "${local.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "subnet-core-02"
      subnet_ip             = "10.13.2.0/24"
      subnet_region         = "${local.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
    {
      subnet_name           = "subnet-core-03"
      subnet_ip             = "10.13.3.0/24"
      subnet_region         = "${local.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
  ]

  secondary_ranges = {
    subnet-core-00 = []
    subnet-core-01 = []
    subnet-core-02 = []
    subnet-core-03 = []
  }
}
