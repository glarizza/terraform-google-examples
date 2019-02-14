resource "google_compute_instance" "main" {
  count                     = "${length(local.ip_address_names)}"
  name                      = "${local.instance_name_prefix}-${format("%03d", count.index + 1)}"
  machine_type              = "${local.machine_type}"
  zone                      = "${local.region}-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    subnetwork = "${module.network.subnets_self_links[0]}"
    network_ip = "${module.address.addresses[count.index]}"
  }
}
