terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}

provider "hcloud" {
  token = var.hcloud_token
}

# Create a server
resource "hcloud_server" "web" {
    name = "web"
    image = "ubuntu-20.04"
    server_type = "cx11"
    location = "nbg1"
}
