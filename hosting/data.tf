data "aws_iam_policy_document" "bucket_policy" {
  statement {
    effect = "Allow"

    principals {
      identifiers = [
        "*",
      ]

      type = "AWS"
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.frontend.arn}/*",
    ]
  }
}