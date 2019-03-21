variable "project_id" {
  description = "The Project ID used"
}

variable "crypto_key" {
  description = "The crypto key ID"
}

variable "certificate_ciphertext" {
  description = "Ciphertext of encrypted certificate secret"
  default     = ""
}

variable "key_ciphertext" {
  description = "Ciphertext of encrypted key secret"
  default     = ""
}
