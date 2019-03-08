resource "google_project_iam_custom_role" "iam_custom_role" {
  project = "${module.service-project.project_id}"
  role_id = "iam_custom_role"
  title   = "iam_custom_role"

  permissions = [
    "compute.instanceGroupManagers.get",
    "compute.instanceGroupManagers.list",
    "compute.instanceGroups.list",
    "compute.instances.attachDisk",
    "compute.instances.get",
    "compute.instances.list",
    "compute.targetInstances.list",
    "compute.zones.get",
    "compute.zones.list",
    "storage.objects.get",
    "storage.objects.list",
  ]
}

resource "google_project_iam_member" "iam_custom_role_binding" {
  project = "${module.service-project.project_id}"
  role    = "${google_project_iam_custom_role.iam_custom_role.id}"
  member  = "serviceAccount:${module.service-project.project_number}-compute@developer.gserviceaccount.com"
}
