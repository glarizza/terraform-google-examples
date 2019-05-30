# Service account configuration

The intent of this module is to generate a service account that will be used to
execute both the `kms_setup` and `certs_and_lbs` modules. The purpose is to
demonstrate which IAM roles are necessary for whatever service account will be
used to execute this code in your environment.

The only input variable available is `project_id`, so once you provide that simply run Terraform:

    terraform init
    terraform plan -out sa.out
    terraform apply sa.out

THIS module must be executed with an identity/service account that has enough
permission to create a service account with the project specified by 
`project_id` and assign IAM roles to it.