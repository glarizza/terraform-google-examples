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

variable "certificate2_ciphertext" {
  description = "Ciphertext of a second encrypted certificate secret"
  default     = ""
}

variable "key2_ciphertext" {
  description = "Ciphertext of a second encrypted key secret"
  default     = ""
}

variable "region" {
  description = "The region where infrastructure will be created"
  default     = "us-west1"
}
