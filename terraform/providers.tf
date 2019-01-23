provider "aws" {
  version                 = "~> 1.54"
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.aws_shared_credentials_file}"
  profile                 = "${var.aws_profile}"

  assume_role {
    role_arn = "${var.aws_role_arn}"
  }
}

provider "template" {
  version = "~> 1.0"
}
