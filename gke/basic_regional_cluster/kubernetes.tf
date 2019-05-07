locals {
  cluster_type       = "simple-regional"
  secondary_ranges   = "${module.network.subnets_secondary_ranges[0]}"
  pods_range_map     = "${local.secondary_ranges[0]}"
  services_range_map = "${local.secondary_ranges[1]}"
}

provider "google" {
  version = "~> 2.3.0"
  region  = "${var.region}"
}

provider "google-beta" {
  version = "~> 2.3.0"
  region  = "${var.region}"
}

module "gke" {
  source            = "github.com/terraform-google-modules/terraform-google-kubernetes-engine"
  project_id        = "${module.gke-basic-project.project_id}"
  name              = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  regional          = true
  region            = "${var.region}"
  network           = "${module.network.network_name}"
  subnetwork        = "${module.network.subnets_names[0]}"
  ip_range_pods     = "${local.pods_range_map["range_name"]}"
  ip_range_services = "${local.services_range_map["range_name"]}"
  service_account   = "${var.compute_engine_service_account}"
}

data "google_client_config" "default" {}
