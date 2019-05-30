output "crypto_key" {
  value = "${google_kms_crypto_key.crypto_key.id}"
}
