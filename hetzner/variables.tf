variable "hcloud_token" {
  description = "The Hetzner Cloud API token"
  type = string
  sensitive = true
}

variable "srv_mendix_name" {
  description = "The name of the server that is running mendix"
  type = string
}

variable "srv_postgres_name" {
  description = "The name of the server that is running postrges"
  type = string
}

variable "fw_name" {
  description = "The name of the firewall"
  type = string
}

variable "ssh_key_id" {
  description = "ID of the SSH key to use for server access"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the private SSH key file"
  type        = string
}
