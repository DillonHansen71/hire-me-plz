variable "name_suffix" {
  default = ""
}

resource "aws_iam_role" "prod" {
  name = "prod${var.name_suffix}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::account-id-without-hyphens:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "prod" {
  name = "prod${var.name_suffix}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "${aws_iam_role.prod.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_group" "prod" {
  name = "prod${var.name_suffix}"
}

resource "aws_iam_user" "prod" {
  name = "prod${var.name_suffix}"
}

resource "aws_iam_group_policy_attachment" "prod" {
  group = "${aws_iam_group.prod.name}"
  policy_arn = "${aws_iam_policy.prod.arn}"
}

resource "aws_iam_user_group_membership" "prod" {
  user = "${aws_iam_user.prod.name}"
  group = "${aws_iam_group.prod.name}"
}