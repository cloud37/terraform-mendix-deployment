variable "ssh_key_id" {
  description = "ID of the SSH key to use for the bastion host"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the private SSH key for bastion host access"
  type        = string
  sensitive   = true
}
