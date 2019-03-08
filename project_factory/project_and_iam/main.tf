terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/project_and_iam"
  }
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(var.credentials_path)}"
  version     = "~> 1.19"
}

provider "google-beta" {
  credentials = "${file(var.credentials_path)}"
  version     = "~> 1.19"
}

locals {
  service_project_id   = "${local.service_project_name}-${random_string.service_project.result}"
  service_project_name = "gl-project-iam"
}

resource "random_string" "service_project" {
  length  = 5
  special = false
  upper   = false
}

module "service-project" {
  source           = "github.com/terraform-google-modules/terraform-google-project-factory"
  name             = "${local.service_project_name}"
  project_id       = "${local.service_project_id}"
  org_id           = "${var.organization_id}"
  folder_id        = "${var.folder_id}"
  billing_account  = "${var.billing_account}"
  credentials_path = "${var.credentials_path}"
}
