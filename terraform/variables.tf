variable "aws_region" {
  description = "The default region where plan will be applied"
}

variable "aws_shared_credentials_file" {
  description = "Locate the aws credentials file"
}

variable "aws_profile" {
  description = "The name of the configuration profile to use"
}

variable "aws_role_arn" {
  description = "The arn for the role we are to assume"
}
