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

variable "app_domain" {
  description = "The domain prefix for the bucket name, which comes after either `s3-asset-path`"
  type = "string"
  default = "example.com"
}

variable "backend_api_base_url" {
  description = "The URL pointing to your backend API"
  type = "string"
  default = "api.example.com"
}

locals {
  env_suffix = "${terraform.workspace == "production" ? "" : join("", list("-", terraform.workspace))}"
  name = "${var.name}${local.env_suffix}"
}
