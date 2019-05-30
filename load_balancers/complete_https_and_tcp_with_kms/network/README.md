# Network configuration

This module exists as a standalone dependency necessary to create the VPC
network and subnetwork that will be needed for later infrastructure, as well
as the NAT gateway used by the Managed Instance Group (MIG) VM instances so
they can download and install Nginx from yum mirrors (to avoid needing external IP addresses). Should you already have all of these resources then
this module isn't necessary, however this module is tightly-coupled with the
`certs_and_lbs` module (for providing the network and subnetwork name), so
modifications will need to be made there.

The only input variables required are `project_id` and `region`, so once those
have been configured simply execute Terraform:

    terraform init
    terraform plan -out network.out
    terraform apply network.out

THIS module must be executed with an identity/service account that has enough
permission to create a network/subnetwork within `project_id` and bring up the
NAT gateway.