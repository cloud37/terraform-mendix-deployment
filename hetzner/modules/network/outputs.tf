output "network_id" {
  description = "ID of the created private network"
  value       = hcloud_network.private.id
}

output "subnet_id" {
  description = "ID of the created private subnet"
  value       = hcloud_network_subnet.private_subnet.id
}
