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

resource "hcloud_server" "mendix_01" {
    name = var.srv_mendix_name
    image = "ubuntu-20.04"
    server_type = "cx11"
    location = "nbg1"
}

#00SOZrHGmt3ZfZzWLwl850ZwClnYwZNBwD3r0GHR4keC6MstRmCWPJBRnsoePYlm