output "host_bucket" {
  value = "${aws_s3_bucket.frontend.bucket}"
}

output "distribution_id" {
  value = "${aws_cloudfront_distribution.frontend.id}"
}
