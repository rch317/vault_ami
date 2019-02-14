resource "aws_codebuild_project" "ami" {
  name          = "vault_ami"
  description   = "Create AMI for Vault"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_ami.arn}"
  badge_enabled = "true"

  artifacts {
    type = "NO_ARTIFACTS"
  }

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
    compute_type = "BUILD_GENERAL1_MEDIUM"

    // image        = "aws/codebuild/ubuntu-base:14.04"
    image = "aws/codebuild/eb-python-2.6-amazonlinux-64:2.1.6"
    type  = "LINUX_CONTAINER"

    // privileged_mode = "true"

    environment_variable {
      "name"  = "AWS_REGION"
      "value" = "${var.aws_region}"
    }
    environment_variable {
      "name"  = "AWS_VPC_ID"
      "value" = "${module.vpc.vpc_id}"
    }
    environment_variable {
      "name"  = "AWS_SUBNET_ID"
      "value" = "${module.vpc.private_subnets[0]}"
    }
    environment_variable {
      "name"  = "VAULT_VERSION"
      "value" = "1.0.0"
    }
    environment_variable {
      "name"  = "CONSUL_VERSION"
      "value" = "1.3.1"
    }
    environment_variable {
      "name"  = "VAULT_DOWNLOAD_URL"
      "value" = "https://releases.hashicorp.com/vault/1.0.0/vault_1.0.0_linux_arm64.zip"
    }
    environment_variable {
      "name"  = "CONSUL_DOWNLOAD_URL"
      "value" = "https://releases.hashicorp.com/consul/1.3.1/consul_1.3.1_linux_amd64.zip"
    }
  }

  tags = {
    "Name"      = "vault_ami"
    "Terraform" = "true"
  }
}