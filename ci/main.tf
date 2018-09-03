resource "aws_iam_role" "ci" {
  name               = "${var.name}-ci"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role.json}"
}
resource "aws_iam_role_policy" "ci" {
  policy = "${data.aws_iam_policy_document.ci-access.json}"
  role   = "${aws_iam_role.ci.id}"
}