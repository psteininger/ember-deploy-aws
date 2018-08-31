resource "aws_s3_bucket" "frontend" {
  bucket = "${local.bucket_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = [
      "*",
    ]

    allowed_methods = [
      "GET",
      "HEAD",
    ]

    allowed_origins = [
      "http://${local.bucket_name}",
      "https://${local.bucket_name}",
    ]

    expose_headers = [
      "ETag",
    ]

    max_age_seconds = 3000
  }

  tags {
    Name        = "${var.name}"
    Environment = "${terraform.workspace}"
  }
}
resource "aws_s3_bucket_policy" "frontend" {
  bucket = "${aws_s3_bucket.frontend.id}"
  policy = "${data.aws_iam_policy_document.bucket_policy.json}"
}

