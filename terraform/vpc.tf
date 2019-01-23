module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.49.0"

  cidr = "192.168.10.0/24"
  name = "codebuild-ami"

  //  datasources.tf or set as a list
  azs = "${data.aws_availability_zones.available.names}"

  // Not really sure we need public subnets - defined here anyways.
  public_subnets  = ["192.168.10.0/26", "192.168.10.64/26"]
  private_subnets = ["192.168.10.128/26", "192.168.10.192/26"]

  // not sure we need nat gateway...
  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
  }

  public_subnet_tags = {
    is_public = "true"
  }

  private_subnet_tags = {
    is_public = "false"
  }
}
