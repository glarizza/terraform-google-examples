terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/complete_https_and_tcp_with_kms/service_account"
  }
}

resource "google_project_service" "iam" {
  project = "${var.project_id}"
  service = "iam.googleapis.com"
}

resource "google_project_service" "resourcemanager" {
  project = "${var.project_id}"
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "compute" {
  project = "${var.project_id}"
  service = "compute.googleapis.com"
}

resource "google_service_account" "load-balancer" {
  account_id   = "load-balancer"
  display_name = "Load balancer creation SA"
  project      = "${var.project_id}"

  depends_on = [
    "google_project_service.resourcemanager",
  ]
}

# Needed to be able to create the KMS keyring and crypto key. Does NOT include
# either encypt or decrypt permissions - those are separate
resource "google_project_iam_member" "kms_admin" {
  project = "${var.project_id}"
  role    = "roles/cloudkms.admin"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed to be able to decrypt a secret that has already been encrypted
resource "google_project_iam_member" "kms_decrypter" {
  project = "${var.project_id}"
  role    = "roles/cloudkms.cryptoKeyDecrypter"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed to be able to enable service APIs
resource "google_project_iam_member" "quota_admin" {
  project = "${var.project_id}"
  role    = "roles/servicemanagement.quotaAdmin"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed to create the LB and SSL certificate resources
resource "google_project_iam_member" "lb_admin" {
  project = "${var.project_id}"
  role    = "roles/compute.loadBalancerAdmin"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed to list the compute zones (among other things)
resource "google_project_iam_member" "security_admin" {
  project = "${var.project_id}"
  role    = "roles/compute.securityAdmin"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed for compute.instanceTemplates.useReadOnly
resource "google_project_iam_member" "instance_admin" {
  project = "${var.project_id}"
  role    = "roles/compute.instanceAdmin"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed to view the instance group templates
resource "google_project_iam_member" "compute_viewer" {
  project = "${var.project_id}"
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}

# Needed to access the default compute SA to attach to the MIG
resource "google_project_iam_member" "sa_user" {
  project = "${var.project_id}"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.load-balancer.email}"
}
