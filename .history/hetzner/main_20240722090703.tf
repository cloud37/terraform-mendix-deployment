terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "mendix" {
    name = var.srv_mendix_name
    image = "ubuntu-20.04"
    server_type = "cx11"
    location = "nbg1"
}
