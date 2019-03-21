data "google_kms_secret" "certificate" {
  crypto_key = "${var.crypto_key}"
  ciphertext = "${var.certificate_ciphertext}"
}

data "google_kms_secret" "key" {
  crypto_key = "${var.crypto_key}"
  ciphertext = "${var.key_ciphertext}"
}

resource "google_compute_ssl_certificate" "kms_certificate" {
  name_prefix = "kms-certificate"
  description = "SSL certificate coming from KMS"
  project     = "${var.project_id}"
  private_key = "${data.google_kms_secret.key.plaintext}"
  certificate = "${data.google_kms_secret.certificate.plaintext}"

  lifecycle {
    create_before_destroy = true
  }
}
