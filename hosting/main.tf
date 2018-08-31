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

resource "aws_cloudfront_distribution" "frontend" {
  origin {
    domain_name = "${aws_s3_bucket.frontend.bucket_regional_domain_name}"
    origin_id   = "${aws_s3_bucket.frontend.bucket}"
  }

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]

    cached_methods = [
      "GET",
      "HEAD",
    ]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    target_origin_id       = "${aws_s3_bucket.frontend.bucket}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  custom_error_response {
    error_code         = "404"
    response_page_path = "/index.html"
    response_code      = "200"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [
    "${aws_s3_bucket.frontend.bucket}",
  ]

  price_class = "PriceClass_200"

  tags {
    Name        = "${var.name}"
    Environment = "${terraform.workspace}"
  }
}
