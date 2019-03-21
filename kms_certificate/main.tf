module "keyring_and_key" {
  source     = "./modules/keyring_and_key"
  project_id = "${var.project_id}"
  region     = "${var.region}"
}

module "certificate" {
  source                 = "./modules/certificate"
  project_id             = "${var.project_id}"
  crypto_key             = "${module.keyring_and_key.crypto_key}"
  certificate_ciphertext = "${var.certificate_ciphertext}"
  key_ciphertext         = "${var.key_ciphertext}"
}
