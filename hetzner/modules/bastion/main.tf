terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "bastion" {
  name        = "bastion-host"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = "nbg1"

  ssh_keys = [var.ssh_key_id]

  provisioner "remote-exec" {
    inline = ["echo 'Bastion host is ready!'"]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = self.ipv4_address
    }
  }
}
