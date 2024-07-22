variable "network_id" {
  description = "ID of the network to which the server will be connected"
  type        = string
}

variable "firewall_id" {
  description = "ID of the firewall to attach to the server"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet within the network"
  type        = string
}

variable "ssh_key_id" {
  description = "ID of the SSH key to be used for access"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the private SSH key for server access"
  type        = string
  sensitive   = true
}
