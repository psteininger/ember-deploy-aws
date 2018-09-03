data "aws_region" "current" {}

data "aws_iam_policy_document" "assume-role" {
  statement {
    effect = "Allow"

    principals {
      identifiers = [
        "codebuild.amazonaws.com",
      ]

      type = "Service"
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

data "aws_iam_policy_document" "ci-access" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}::log-group:/aws/codebuild/${var.name}",
      "arn:aws:logs:${data.aws_region.current.name}::log-group:/aws/codebuild/${var.name}:*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameters",
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}::parameter/CodeBuild/*",
      "arn:aws:ssm:${data.aws_region.current.name}::parameter/${var.name}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectACL",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.host_bucket}",
      "arn:aws:s3:::${var.host_bucket}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
    ]

    resources = [
      "*",
    ]
  }
}
