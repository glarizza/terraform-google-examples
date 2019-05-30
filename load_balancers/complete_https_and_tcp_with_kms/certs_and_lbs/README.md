# SSL certificates from KMS secrets and load balancer configuration

This module is where the key resources are finally declared and associated with
one another. This module handles the following:

1. Creates the Managed Instance Groups (MIGs) for both the HTTPS and TCP load balancer
2. Creates SSL certificate resources from the KMS secrets encrypted in the previous module
3. Creates both the HTTPS and TCP load balancer and ensures their backend pools are tied to the correct MIGs

## Executing the module

If you followed the steps in the `kms_setup` module then you should already
have created a `terraform.tfvars` file in this directory with the contents
of each SSL certificate/private key's ciphertext to be provided as input
variables. Once the `project_id` and `region` have also been specified then
the module is ready for execution.

Make sure that the `GOOGLE_APPLICATION_CREDENTIALS` environment variable has
been populated with the path to the JSON key for the load balancer service
account that was created by the first module. If it has not been set or the
JSON key has not been downloaded, then you will need to ensure both of those
steps have been followed

Finally, execute Terraform:

    terraform init
    terraform plan -out lb.out
    terraform apply lb.out

## A note on tight couplings

The `certs_and_lbs` module is tightly coupled with the `network` module in that
it dips into remote state for the network name and subnetwork to be used for
all the infrastructure, so if you're not using the `network` module you will
need to modify those couplings. Also, the HTTPS load balancer is coupled with
the MIG resources, and the MIG for the TCP load balancer is coupled with the
load balancer resource, so if the example MIGs aren't being used then those
couplings need to be modified.

