# Complete HTTPS/TCP load balancer example using KMS

This folder contains four separate Terraform modules that together build both
an HTTPS load balancer (that sources its certificates from KMS) as well as a
TCP load balancer. Each module has its own separate purpose and must be
executed in the correct order:


## The `service_account` module

This module is meant to build the service account that will be used for both the
`kms_setup` and `certs_and_lbs` modules. I've tried to identify the predefined
roles that are needed to completely stand up all that infrastructure based on
[Google's "Understanding Roles" page.](https://cloud.google.com/iam/docs/understanding-roles)
Some of these roles may be overkill (specifically `compute.securityAdmin`), but
the main purpose was identifying the reason behind each predefined that I chose.

This module itself must be executed with an identity/service account that has
enough permission to create a service account within a project and assign it
IAM roles.

## The `network` module

This module exists as a standalone dependency necessary to create the VPC network
and subnetwork that will be needed for all infrastructure, as well as the NAT
gateway that will be used to route traffic outbound (instead of assigning all
infrastructure external IP addresses). If you already have these things setup
you're free to omit this module, but if you don't it's there to help you out.

This module must be executed with an identity/service account that has enough
permission to create a network within a project and bring up the NAT gateway.

## The `kms_setup` module

This module enables the Cloud KMS API and creates the KMS keyring and crypto
key that will be used in the process of encrypting and decrypting the
contents of the SSL certificate and private key as KMS secrets. This module has
a series of steps that must be followed outside running Terraform in order to
create a self-signed SSL certificate/private key and encrypt their contents as
KMS secrets.

The intent is that the service account created by the `service_account` module
will be used to execute this Terraform module (as the KMS steps are considered
part of this example and not a dependency of it).

## The `certs_and_lbs` module

This module will create two Managed Instance Groups (MIGs) as backends for the
HTTPS load balancer, a MIG as a backend for the TCP load balancer, and create
both of those load balancers once the MIGs are stood up. The MIGs created are
for demonstration purposes (as I'm sure you'll have your own backend services),
but I kept them together with the load balancers to make it easer to reference
each other (as opposed to dipping into remote state, which is what you'll most
likely end up doing). Each MIG uses a CentOS 7 image and has a startup script
that installs and starts Nginx so that health checks pass.

The intent is that the service account created by the `service_account` module
will be used to execute this Terraform module.

