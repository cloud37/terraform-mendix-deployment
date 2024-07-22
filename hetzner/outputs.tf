output "bastion_ip" {
  description = "The public IP address of the bastion host"
  value       = module.bastion.bastion_ip
}

output "network_id" {
  description = "ID of the created private network"
  value       = module.network.network_id
}

output "subnet_id" {
  description = "ID of the created private subnet"
  value       = module.network.subnet_id
}

output "firewall_id" {
  description = "ID of the created firewall"
  value       = module.firewall.firewall_id
}
