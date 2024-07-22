terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "database" {
  name        = "database-server"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = "nbg1"

  network {
    network_id = var.network_id
    ip         = "10.0.1.3"
  }

  firewall_ids = [var.firewall_id]

  ssh_keys = [var.ssh_key_id]

  provisioner "remote-exec" {
    inline = ["echo 'Server is ready!'"]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = self.ipv4_address
    }
  }

  provisioner "file" {
    source      = "${path.root}/../scripts/install_postgres_deps.sh"
    destination = "/tmp/install_postgres_deps.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = self.ipv4_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_postgres_deps.sh",
      "/tmp/install_postgres_deps.sh",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = self.ipv4_address
    }
  }
}
