/*********************/
/*       Role         /
/*********************/

variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = "list"
}

variable "role_name" {
  description = "IAM role name"
  type        = "string"
}

variable "role_description" {
  description = "IAM role description"
  type        = "string"
}

variable "role_tags" {
  description = "A map of tags to add to IAM role resources"
  type        = "map"
}

/*********************/
/*      Policy        /
/*********************/

variable "policy_name" {
  description = "The name of the policy"
  type        = "string"
}

variable "policy_description" {
  description = "The description of the policy"
  type        = "string"
}

variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = "string"
}

variable "role" {
  description = "The role ARN to attach the policy"
  type        = "string"
}

/*********************/
/*   Secret Manager   /
/*********************/

variable "secret_name" {
  description = "The name of the secret"
  type        = "string"
}

variable "secret_description" {
  description = "The description of the secret"
  type        = "string"
}

variable "alias_key" {
  description = "The alias assigned to the encryption key used for secrets"
  type        = "string"
}

variable "secret_tags" {
  description = "A map of tags to add to secret resources"
  type        = "map"
}

variable "secret_key_name" {
  description = "The key name of the secret (key/value pair)"
  type        = "string"
}

variable "secret_length" {
  description = "The length of secret value"
  type        = "string"
  default     = "16"
}

variable "secret_min_upper" {
  description = "The minimum number of uppercase char in the secret value"
  type        = "string"
  default     = "2"
}

variable "secret_min_lower" {
  description = "The minimum number of lowercase char in the secret value"
  type        = "string"
  default     = "2"
}

variable "secret_min_numeric" {
  description = "The minimum number of numeric char in the secret value"
  type        = "string"
  default     = "2"
}