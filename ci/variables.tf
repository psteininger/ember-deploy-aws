variable "name" {
  description = "name of the hosted app"
  type = "string"
}
variable "host_bucket" {
  description = "name of the bucket, where the app is hosted"
  type = "string"
}
variable "app_repo" {
  description = "repository <org_or_user/repo_name> with the code of the Ember app being deployed"
  type = "string"
  default = "psteininger/ember-deploy-app"
}
variable "github_token" {
  type = "string"
}
variable "backend_api_base_url" {
  type = "string"
}
variable "cf_distribution_id" {
  type = "string"
}