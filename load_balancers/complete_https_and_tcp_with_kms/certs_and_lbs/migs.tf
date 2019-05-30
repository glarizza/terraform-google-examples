provider "google" {
  project = "${var.project_id}"
  version = "~> 1.19"
}

provider "google-beta" {
  project = "${var.project_id}"
  version = "~> 1.19"
}

locals {
  target_tags = [
    "${data.terraform_remote_state.network.routing_tag_regional}",
  ]
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config {
    bucket = "phoogle-gary-state-bucket"
    prefix = "state/complete_https_and_tcp_with_kms/network"
  }
}

# Startup script that installs and starts Nginx
data "template_file" "group-startup-script" {
  template = "${file("${format("%s/nginx.sh.tpl", path.module)}")}"
}

module "instance_template" {
  #source         = "terraform-google-modules/vm/google//modules/instance_template"
  source         = "git@github.com:glarizza/terraform-google-vm.git?ref=gl/outputs//modules/instance_template"
  subnetwork     = "${data.terraform_remote_state.network.subnets_self_links[0]}"
  startup_script = "${data.template_file.group-startup-script.rendered}"
  tags           = ["${local.target_tags}"]

  service_account = {
    scopes = [
      "cloud-platform",
    ]
  }
}

module "mig" {
  #source            = "terraform-google-modules/vm/google//modules/mig"
  source            = "git@github.com:glarizza/terraform-google-vm.git?ref=gl/outputs//modules/mig"
  region            = "${var.region}"
  target_size       = "2"
  hostname          = "lb-mig"
  instance_template = "${module.instance_template.self_link}"

  update_policy = [
    {
      minimal_action = "REPLACE"
      type           = "OPPORTUNISTIC"
    },
  ]
}

module "mig2" {
  #source            = "terraform-google-modules/vm/google//modules/mig"
  source            = "git@github.com:glarizza/terraform-google-vm.git?ref=gl/outputs//modules/mig"
  region            = "${var.region}"
  target_size       = "2"
  hostname          = "lb-mig2"
  instance_template = "${module.instance_template.self_link}"

  update_policy = [
    {
      minimal_action = "REPLACE"
      type           = "OPPORTUNISTIC"
    },
  ]
}

module "tcp_mig" {
  #source            = "terraform-google-modules/vm/google//modules/mig"
  source            = "git@github.com:glarizza/terraform-google-vm.git?ref=gl/outputs//modules/mig"
  region            = "${var.region}"
  target_size       = "2"
  target_pools      = ["${module.tcp_load_balancer.target_pool}"]
  hostname          = "tcp-mig1"
  instance_template = "${module.instance_template.self_link}"

  update_policy = [
    {
      minimal_action = "REPLACE"
      type           = "OPPORTUNISTIC"
    },
  ]
}
