variable "hcloud_token" {
  sensitive = true
}

provider "hcloud" {
  token = var.hcloud_token
  project = "homelab"
}

resource "hcloud_server" {
    name = "athena"
    type = "cx32"
    image = "debian-12"
    datacenter = "nbg1-dc3"
}

data "cloudinit_config" "athena" {
    part {
      filename = "cloud-config.yaml"
      content_type = "text/cloud-config"

      content = file("${path.module}/cloud-config.yaml")
    }
}