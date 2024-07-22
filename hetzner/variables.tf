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
