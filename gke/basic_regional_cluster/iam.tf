# These project-level IAM bindings are to ensure I can access the cluster and
# the compute engine API on the newly-created project. Disregard these if you
# already have sufficient access control in place.

resource "google_project_iam_member" "container_admin" {
  project = "${module.gke-basic-project.project_id}"
  role    = "roles/container.admin"
  member  = "${var.access_user}"
}

resource "google_project_iam_member" "compute_admin" {
  project = "${module.gke-basic-project.project_id}"
  role    = "roles/compute.admin"
  member  = "${var.access_user}"
}
