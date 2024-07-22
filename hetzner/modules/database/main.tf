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

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y postgresql postgresql-contrib
              # Configure PostgreSQL to listen on the private network interface
              echo "listen_addresses = '10.0.1.3'" >> /etc/postgresql/12/main/postgresql.conf
              echo "host    all    all    10.0.1.0/24    md5" >> /etc/postgresql/12/main/pg_hba.conf
              systemctl restart postgresql
              EOF
}
