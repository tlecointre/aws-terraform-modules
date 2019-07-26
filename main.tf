/*********************/
/*       Role         /
/*********************/

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = "${var.trusted_role_arns}"
    }

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "${var.role_name}"
  description        = "${var.role_description}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"

  tags = "${var.role_tags}"
}

/*********************/
/*      Policy        /
/*********************/

resource "aws_iam_policy" "policy" {
  name        = "${var.policy_name}"
  description = "${var.policy_description}"
  policy      = "${var.policy}"
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = "${var.role}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

/*********************/
/*   Secret Manager   /
/*********************/

data "aws_kms_key" "encryption_key" {
  key_id       = "${var.alias_key}"
}

resource "random_string" "secret" {
  length       = "${var.secret_length}"
  special      = false
  min_upper    = "${var.secret_min_upper}"
  min_lower    = "${var.secret_min_lower}"
  min_numeric  = "${var.secret_min_numeric}"
}

resource "aws_secretsmanager_secret" "secret" {
  description  = "${var.secret_description}"
  kms_key_id   = "${data.aws_kms_key.encryption_key.key_id}"
  name         = "${var.secret_name}"
  tags         = "${var.secret_tags}"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = "${aws_secretsmanager_secret.secret.id}"
  secret_string = "{\"${var.secret_key_name}\":\"${random_string.secret.result}\"}"
}