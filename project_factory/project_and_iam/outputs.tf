output "project_number" {
  value       = "${module.service-project.project_number}"
  description = "The numerical id of the project created"
}

output "service_account_id" {
  value       = "${module.service-project.service_account_id}"
  description = "The id of the default service account"
}

output "service_account_display_name" {
  value       = "${module.service-project.service_account_display_name}"
  description = "The display name of the default service account"
}

output "service_account_email" {
  value       = "${module.service-project.service_account_email}"
  description = "The email of the default service account"
}

output "service_account_name" {
  value       = "${module.service-project.service_account_name}"
  description = "The fully-qualified name of the default service account"
}

output "service_account_unique_id" {
  value       = "${module.service-project.service_account_unique_id}"
  description = "The unique id of the default service account"
}
