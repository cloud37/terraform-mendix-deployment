variable "hcloud_token" {
  description = "The Hetzner Cloud API token"
  type = string
  sensitive = true
}

variable "srv_mendix_name" {
  description = "The name of the server"
  type = string
}
