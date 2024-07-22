output "network_id" {
  value = hcloud_network.private.id
}

output "subnet_id" {
  value = hcloud_network_subnet.private_subnet.id
}
