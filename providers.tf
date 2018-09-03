provider "aws" {
  region = "eu-central-1"
  profile = "emberjs"
  version = "~> 1.32"
}
provider "cloudflare" {
  email   = "${var.cloudflare_email}"
  token   = "${var.cloudflare_api_token}"
  version = "~> 1.2"
}
provider "github" {
  organization = "psteininger"
  token = "${var.github_token}"
  version      = "~> 1.2"
}