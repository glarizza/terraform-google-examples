terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/project_factory/shared_vpc_setup/host_project"
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

locals {
  host_project_id   = "${local.host_project_name}-${random_string.host_project.result}"
  host_project_name = "gl-shared-vpc-host"
}

resource "random_string" "host_project" {
  length  = 5
  special = false
  upper   = false
}

module "host-project" {
  source            = "github.com/terraform-google-modules/terraform-google-project-factory"
  random_project_id = false
  name              = "${local.host_project_name}"
  project_id        = "${local.host_project_id}"
  org_id            = "${var.organization_id}"
  folder_id         = "${var.folder_id}"
  billing_account   = "${var.billing_account}"
  credentials_path  = "${var.credentials_path}"
}
