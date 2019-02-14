# DNS Zones and Cloud DNS Example

This example models using the [network
module](https://github.com/terraform-google-modules/terraform-google-network)
to setup a basic VPC network and subnet, the [address
module](https://github.com/terraform-google-modules/terraform-google-address)
to reserve three IP addresses within that subnet and register those IP
addresses with Cloud DNS, manages the Cloud DNS forward and reverse zones
with their own resources, and spins up a CentOS 7 Google compute instance for
each IP Address that was reserved.

## Note on destruction

You will need to run `terraform destroy` twice because a Google Cloud DNS
zone cannot be deleted until all DNS records have been deleted, so the first
time you destroy it will delete the records and complain about the zone, and
then the second time it will delete the zones.