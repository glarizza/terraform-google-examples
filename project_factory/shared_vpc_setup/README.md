# Project Factory: Shared VPC Setup

This directory contains two example Terraform configurations:

1. A Shared VPC host project with a network and several subnetworks
2. A Shared VPC service project that has two of the subnetworks assigned to it

## Usage

This folder is meant as an example and is opinionated about certain things
(subnetwork names and ranges, project names), but you can adapt that to your
needs if you want. The biggest change you'll need to make is to use a
different state bucket name (I left mine in there as an example - if you try
to run things as-is you will definitely get an error because you can't access
my state bucket). 

You'll also need to make sure that `shared/terraform.tfvars` is configured with
your `folder_id`, `organization_id`, `billing_account`, and `credentials_path`.
The `shared/terraform.tfvars.example` is provided as an example - simply copy it
to `shared/terraform.tfvars` and complete it with your information. Symlinks have
been provided from that file to each directory, so that much has been done for you.

With those modifications, Terraform should be run in the following order:

1. Change to the `host_project` directory and execute `terraform` to stand up the host project and networks
2. Change to the `service_project` directory and execute `terraform` to stand up the service project


