terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
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

module "bastion" {
  source               = "./modules/bastion"
  ssh_key_id           = var.ssh_key_id
  ssh_private_key_path = var.ssh_private_key_path
}

module "firewall" {
  source = "./modules/firewall"
  bastion_ip = module.bastion.bastion_ip
}

module "database" {
  source               = "./modules/database"
  network_id           = module.network.network_id
  firewall_id          = module.firewall.firewall_id
  subnet_id            = module.network.subnet_id
  ssh_key_id           = var.ssh_key_id
  ssh_private_key_path = var.ssh_private_key_path
}

module "application" {
  source               = "./modules/application"
  network_id           = module.network.network_id
  firewall_id          = module.firewall.firewall_id
  subnet_id            = module.network.subnet_id
  ssh_key_id           = var.ssh_key_id
  ssh_private_key_path = var.ssh_private_key_path
}
