terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/project_factory/shared_vpc_setup/service_project"
  }
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(var.credentials_path)}"
  version     = "~> 2.0"
}

provider "google-beta" {
  credentials = "${file(var.credentials_path)}"
  version     = "~> 2.0"
}

/******************************************
  Remote state declaration
 *****************************************/
data "terraform_remote_state" "host_project" {
  backend = "gcs"

  config {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/project_factory/shared_vpc_setup/host_project"
  }
}

locals {
  host_project_id      = "${data.terraform_remote_state.host_project.project_id}"
  service_project_id   = "${local.service_project_name}-${random_string.service_project.result}"
  service_project_name = "gl-shared-vpc-service"

  subnets_allowed = [
    "projects/${local.host_project_id}/regions/${data.terraform_remote_state.host_project.subnets_regions[0]}/subnetworks/${data.terraform_remote_state.host_project.subnets_names[0]}",
    "projects/${local.host_project_id}/regions/${data.terraform_remote_state.host_project.subnets_regions[1]}/subnetworks/${data.terraform_remote_state.host_project.subnets_names[1]}",
  ]
}

resource "random_string" "service_project" {
  length  = 5
  special = false
  upper   = false
}

module "service-project" {
  source             = "github.com/terraform-google-modules/terraform-google-project-factory"
  name               = "${local.service_project_name}"
  project_id         = "${local.service_project_id}"
  org_id             = "${var.organization_id}"
  folder_id          = "${var.folder_id}"
  billing_account    = "${var.billing_account}"
  credentials_path   = "${var.credentials_path}"
  shared_vpc         = "${local.host_project_id}"
  shared_vpc_subnets = "${local.subnets_allowed}"
}
