output "bastion_ip" {
  description = "The public IP address of the bastion host"
  value       = hcloud_server.bastion.ipv4_address
}
