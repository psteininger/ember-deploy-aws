module "hosting" {
  source = "./hosting"
  app_domain = "${var.app_domain}"
  name   = "${local.name}"
}

module "ci" {
  source = "./ci"
  name   = "${local.name}"
  host_bucket = "${module.hosting.host_bucket}"
  cf_distribution_id = "${module.hosting.distribution_id}"
  backend_api_base_url = "${var.backend_api_base_url}"
  github_token = "${var.github_token}"
}