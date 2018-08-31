variable "cloudflare_email" {
  type = "string"
}

variable "cloudflare_api_token" {
  type = "string"
}

variable "github_token" {
  type = "string"
}

variable "name" {
  type = "string"
  default = "app"
}

locals {
  env_suffix = "${terraform.workspace == "production" ? "" : join("", list("-", terraform.workspace))}"
  name = "${var.name}${local.env_suffix}"
}