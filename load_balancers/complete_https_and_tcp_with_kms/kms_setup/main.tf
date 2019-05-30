terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/complete_https_and_tcp_with_kms/kms_setup"
  }
}

resource "google_project_service" "enable_destination_api" {
  project            = "${var.project_id}"
  service            = "cloudkms.googleapis.com"
  disable_on_destroy = false
}

resource "google_kms_key_ring" "key_ring" {
  project  = "${var.project_id}"
  name     = "load-balancer-key-ring"
  location = "${var.region}"

  depends_on = [
    "google_project_service.enable_destination_api",
  ]
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "load-balancer-crypto-key"
  key_ring = "${google_kms_key_ring.key_ring.id}"

  depends_on = [
    "google_project_service.enable_destination_api",
  ]
}
