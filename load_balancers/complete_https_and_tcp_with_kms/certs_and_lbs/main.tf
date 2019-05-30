terraform {
  required_version = "~> 0.11"

  backend "gcs" {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/complete_https_and_tcp_with_kms/network"
  }
}

module "https_load_balancer" {
  source               = "GoogleCloudPlatform/lb-http/google"
  name                 = "demo-lb"
  ssl                  = true
  use_ssl_certificates = true
  target_tags          = ["${local.target_tags}"]
  firewall_networks    = ["${data.terraform_remote_state.network.network_name}"]

  ssl_certificates = [
    "${google_compute_ssl_certificate.kms_certificate.self_link}",
    "${google_compute_ssl_certificate.kms_certificate2.self_link}",
  ]

  backends = {
    "0" = [
      {
        group = "${module.mig.instance_group}"
      },
      {
        group = "${module.mig2.instance_group}"
      },
    ]
  }

  backend_params = [
    # health check path, port name, port number, timeout seconds.
    "/,http,80,10",
  ]
}

# Allow https traffic to test out the HTTPS LB
resource "google_compute_firewall" "https_traffic" {
  name    = "allow-https"
  network = "${data.terraform_remote_state.network.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

module "tcp_load_balancer" {
  source       = "GoogleCloudPlatform/lb/google"
  region       = "${var.region}"
  name         = "tcp-lb"
  service_port = "80"
  target_tags  = ["${local.target_tags}"]
  network      = "${data.terraform_remote_state.network.network_name}"
}
