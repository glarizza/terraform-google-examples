locals {
  network_name         = "dns-example-network"
  forward_zone         = "dns-example-forward"
  reverse_zone         = "dns-example-reverse"
  domain               = "garytest.org"
  region               = "us-west1"
  machine_type         = "n1-standard-2"
  instance_name_prefix = "customer-dev-appname-fe-0001-a"

  ip_address_names = [
    "customer-dev-appname-fe-0001-a-001-ip",
    "customer-dev-appname-fe-0001-a-002-ip",
    "customer-dev-appname-fe-0001-a-003-ip",
  ]

  dns_short_names = [
    "customer-dev-appname-fe-0001-a-001",
    "customer-dev-appname-fe-0001-a-002",
    "customer-dev-appname-fe-0001-a-003",
  ]
}
