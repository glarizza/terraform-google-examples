resource "google_dns_managed_zone" "forward" {
  name        = "${local.forward_zone}"
  dns_name    = "${local.domain}."
  description = "DNS forward lookup zone example"
}

resource "google_dns_managed_zone" "reverse" {
  name        = "${local.reverse_zone}"
  dns_name    = "10.10.in-addr.arpa."
  description = "DNS reverse lookup zone example"
}
