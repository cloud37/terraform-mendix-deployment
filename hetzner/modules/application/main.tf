terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "application" {
  name        = "application-server"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = "nbg1"

  network {
    network_id = var.network_id
    ip         = "10.0.1.2"
  }

  firewall_ids = [var.firewall_id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              # Configure Nginx to listen on both public and private interfaces
              sed -i 's/listen 80 default_server;/listen 80 default_server;\n    listen 10.0.1.2:80;/' /etc/nginx/sites-available/default
              systemctl restart nginx
              EOF
}
