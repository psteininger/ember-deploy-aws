resource "aws_iam_role" "ci" {
  name               = "${var.name}-ci"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"
}
resource "aws_iam_role_policy" "ci" {
  policy = "${data.aws_iam_policy_document.ci-access.json}"
  role   = "${aws_iam_role.ci.id}"
}
resource "aws_codebuild_project" "ci" {
  name         = "${var.name}"
  service_role = "${aws_iam_role.ci.arn}"

  source {
    type            = "GITHUB"
    location        = "${data.github_repository.app-repo.http_clone_url}"
    git_clone_depth = 1

    auth = {
      type     = "OAUTH"
      resource = "${var.github_token}"
    }

    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/nodejs:8.11.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "API_URL"
      value = "${var.backend_api_base_url}"
    }

    environment_variable {
      name  = "AWS_REGION"
      value = "${data.aws_region.current.name}"
    }

    environment_variable {
      name  = "INDEX_${upper(terraform.workspace)}_BUCKET"
      value = "${var.host_bucket}"
    }

    environment_variable {
      name  = "ASSETS_${upper(terraform.workspace)}_BUCKET"
      value = "${var.host_bucket}"
    }

    environment_variable {
      name  = "CLOUDFRONT_DISTRIBUTION_ID_${upper(terraform.workspace)}"
      value = "${var.cf_distribution_id}"
    }

    environment_variable {
      name  = "EMBER_CLI_DEPLOY_TARGET"
      value = "${terraform.workspace}"
    }
  }

  tags {
    Name        = "${var.name}"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_codebuild_webhook" "ci" {
  project_name  = "${aws_codebuild_project.ci.name}"
  branch_filter = "${terraform.workspace == "staging" ? "master" : terraform.workspace}"
}

resource "github_repository_webhook" "ci" {
  active = true

  events = [
    "push",
  ]

  name       = "web"
  repository = "${data.github_repository.app-repo.name}"

  configuration {
    url          = "${aws_codebuild_webhook.ci.payload_url}"
    secret       = "${aws_codebuild_webhook.ci.secret}"
    content_type = "json"
    insecure_ssl = false
  }
}