data "google_kms_secret" "certificate" {
  crypto_key = "${var.crypto_key}"
  ciphertext = "${var.certificate_ciphertext}"
}

data "google_kms_secret" "certificate2" {
  crypto_key = "${var.crypto_key}"
  ciphertext = "${var.certificate2_ciphertext}"
}

data "google_kms_secret" "key" {
  crypto_key = "${var.crypto_key}"
  ciphertext = "${var.key_ciphertext}"
}

data "google_kms_secret" "key2" {
  crypto_key = "${var.crypto_key}"
  ciphertext = "${var.key2_ciphertext}"
}

resource "google_compute_ssl_certificate" "kms_certificate" {
  name_prefix = "load-balancer-kms-certificate"
  description = "Load Balancer SSL certificate coming from KMS"
  project     = "${var.project_id}"
  private_key = "${data.google_kms_secret.key.plaintext}"
  certificate = "${data.google_kms_secret.certificate.plaintext}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_ssl_certificate" "kms_certificate2" {
  name_prefix = "load-balancer-kms-certificate2"
  description = "Second Load Balancer SSL certificate coming from KMS"
  project     = "${var.project_id}"
  private_key = "${data.google_kms_secret.key2.plaintext}"
  certificate = "${data.google_kms_secret.certificate2.plaintext}"

  lifecycle {
    create_before_destroy = true
  }
}
