variable "name" {
  description = "name of the hosted app"
  type = "string"
  default = "app" # or "app-staging"
}

variable "s3-tld" {
  description = "The domain prefix for the bucket name, which comes after either `s3-asset-path` or `scc-ui-prefix`"
  default     = "example.com"
}
locals {
  bucket_name = "${var.name}.${var.s3-tld}"
}