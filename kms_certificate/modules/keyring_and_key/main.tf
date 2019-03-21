resource "google_project_service" "enable_destination_api" {
  project            = "${var.project_id}"
  service            = "cloudkms.googleapis.com"
  disable_on_destroy = false
}

resource "google_kms_key_ring" "key_ring" {
  project  = "${var.project_id}"
  name     = "demo-key-ring"
  location = "${var.region}"

  depends_on = [
    "google_project_service.enable_destination_api",
  ]
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "demo-crypto-key"
  key_ring = "${google_kms_key_ring.key_ring.id}"

  depends_on = [
    "google_project_service.enable_destination_api",
  ]
}
