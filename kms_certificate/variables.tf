variable "project_id" {
  description = "The Project ID used for the keyring"
}

variable "region" {
  description = "Region for the keyring"
  default     = "us-west1"
}

variable "certificate_ciphertext" {
  description = "Ciphertext of encrypted certificate secret"
  default     = ""
}

variable "key_ciphertext" {
  description = "Ciphertext of encrypted key secret"
  default     = ""
}
