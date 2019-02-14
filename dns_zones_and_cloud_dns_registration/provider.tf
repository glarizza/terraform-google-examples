provider "google" {
  region  = "${local.region}"
  project = "${var.project_id}"
}
