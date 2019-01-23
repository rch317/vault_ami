resource "aws_codebuild_project" "ami" {
  name          = "vault_ami"
  description   = "Create AMI for Vault"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_ami.arn}"
  badge_enabled = "true"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  //   cache {
  //     type = "NO_CACHE"
  //   }

  source {
    type            = "GITHUB"
    location        = "https://github.com/rch317/vault_ami"
    git_clone_depth = 1
  }
  vpc_config {
    vpc_id             = "${module.vpc.vpc_id}"
    subnets            = ["${module.vpc.private_subnets}"]
    security_group_ids = ["${aws_security_group.allow_all_vpc.id}"]
  }
  environment {
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = "aws/codebuild/ubuntu-base:14.04"
    type            = "LINUX_CONTAINER"
    // privileged_mode = "true"

    environment_variable {
      "name"  = "AWS_REGION"
      "value" = "${var.aws_region}"
    }
  }
  tags = {
    "Name"      = "vault_ami"
    "Terraform" = "true"
  }
}
