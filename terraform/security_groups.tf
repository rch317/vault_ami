resource "aws_security_group" "allow_all_vpc" {
  name        = "allow_all_vpc"
  description = "Allows all traffic from this VPC to this VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.10.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "allow_all_vpc"
    Terraform = true
  }
}
