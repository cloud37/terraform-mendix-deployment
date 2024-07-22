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

module "network" {
  source = "./modules/network"
}

module "firewall" {
  source = "./modules/firewall"
}

module "database" {
  source        = "./modules/database"
  network_id    = module.network.network_id
  firewall_id   = module.firewall.firewall_id
  subnet_id     = module.network.subnet_id
}

module "application" {
  source        = "./modules/application"
  network_id    = module.network.network_id
  firewall_id   = module.firewall.firewall_id
  subnet_id     = module.network.subnet_id
}
