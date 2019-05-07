terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "oi-gary-tf-state"
    prefix = "state/gke/basic_regional_cluster"
  }
}

locals {
  project_id   = "${local.project_name}-${random_string.project.result}"
  project_name = "gke-basic-project"
}

resource "random_string" "project" {
  length  = 5
  special = false
  upper   = false
}

module "gke-basic-project" {
  source                      = "github.com/terraform-google-modules/terraform-google-project-factory"
  name                        = "${local.project_name}"
  project_id                  = "${local.project_id}"
  org_id                      = "${var.organization_id}"
  folder_id                   = "${var.folder_id}"
  billing_account             = "${var.billing_account}"
  disable_services_on_destroy = false
}

resource "google_project_service" "gke" {
  project = "${module.gke-basic-project.project_id}"
  service = "container.googleapis.com"
}
