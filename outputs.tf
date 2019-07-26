/*********************/
/*       Role         /
/*********************/

output "role_arn" {
  description = "ARN of IAM role"
  value       = "${aws_iam_role.role.arn}"
}

output "role_name" {
  description = "Name of IAM role"
  value       = "${aws_iam_role.role.name}"
}

/*********************/
/*      Policy        /
/*********************/

output "policy_id" {
  description = "The policy's ID"
  value       = "${aws_iam_policy.policy.id}"
}

output "policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = "${aws_iam_policy.policy.arn}"
}

output "policy_description" {
  description = "The description of the policy"
  value       = "${aws_iam_policy.policy.description}"
}

output "policy_name" {
  description = "The name of the policy"
  value       = "${aws_iam_policy.policy.name}"
}

output "policy" {
  description = "The policy document"
  value       = "${aws_iam_policy.policy.policy}"
}

/*********************/
/*   Secret Manager   /
/*********************/

output "secret_name" {
  description = "Name of the secret"
  value       = "${aws_secretsmanager_secret.secret.name}"
}

output "secret_arn" {
  description = "ARN of the secret"
  value       = "${aws_secretsmanager_secret.secret.arn}"
}