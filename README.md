This terraform module creates a secret in AWS Secret Manager with associated role and policy which grants secret access.

It can be cut in 3 parts:
- IAM-ROLE
- IAM-POLICY
- SECRET-MANAGER

# iam-role

Creates single IAM role which can be assumed by trusted resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| role\_name | IAM role name | string | | yes |
| role\_description | IAM role description | string | | yes |
| role\_tags | A map of tags to add to all resources | map | | yes |
| trusted\_role\_arns | ARNs of AWS entities who can assume these roles | list | | yes |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | ARN of IAM role |
| role\_name | Name of IAM role |

# iam-policy

Creates single IAM policy which grant role access to the secret

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| policy_description | The description of the policy | string | | yes |
| policy_name | The name of the policy | string | | yes |
| policy | The path of the policy in IAM (tpl file) | string | | yes |
| role | The role ARN you want to attach the policy | string | | yes

## Outputs

| Name | Description |
|------|-------------|
| policy_arn | The ARN assigned by AWS to this policy |
| policy_description | The description of the policy |
| policy_id | The policy's ID |
| policy_name | The name of the policy |
| policy | The policy document |

# secret-manager

Create secret in Secret Manager with random value created by terraform

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| secret\_description | The description of the policy | string | | yes |
| secret\_name | Secret name | string | | yes |
| secret\_tags | A map of tags to add to the secret | map | | yes |
| secret\_key\_name | The key name of the secret (key/value pair) | string | | yes |
| secret\_length | The length of secret value | string | 16 | no |
| secret\_min\_upper | The minimum number of uppercase char in the secret value | string | 2 | no |
| secret\_min\_lower | The minimum number of lowercase char in the secret value | string | 2 | no |
| secret\_min\_numeric | The minimum number of numeric char in the secret value | string | 2 | no |

## Outputs

| Name | Description |
|------|-------------|
| secret\_name | Name of the secret |
| secret\_arn | ARN of the secret |

## Usage

```hcl
module "iam_role" {
  source = "aws-terraform-secret"

  role_name         = "fr-myapp-role-secret-retrieval"
  role_description  = "My app role to retrieve secret"
  trusted_role_arns = [
    "arn:aws:iam::164843689524:root"
  ]
  role_tags = {"app_name" = "my_app", "env" = "dev"}

  secret_name = "obk-myapp-cred"
  secret_description = "My secret used by myapp"
  secret_key_name = "my_secret_key_name"
  alias_key = "alias/aws/secretsmanager"
  secret_tags = {"app_name" = "my_app", "env" = "dev"}

  policy_name = "fr-myapp-policy-secret-retrieval"
  policy_description = "My policy to retrieve secret"
  role = "${module.iam_role.role_name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue",
        "secretsmanager:UpdateSecretVersionStage"
      ],
      "Effect": "Allow",
      "Resource": "${module.secret_creation.secret_arn}"
    }
  ]
}
EOF
}
```