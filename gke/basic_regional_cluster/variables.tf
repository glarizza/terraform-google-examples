# Project Factory Variables

variable "organization_id" {
  description = "The organization id for the associated services"
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
}

variable "folder_id" {
  description = "The ID of a folder to host this project"
}

# Kubernetes variables

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-west1"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
  default     = "create"
}

# IAM variables
variable "access_user" {
  description = "The identity that needs to access the cluster"
  default     = "user:gary@openinfrastructure.co"
}
