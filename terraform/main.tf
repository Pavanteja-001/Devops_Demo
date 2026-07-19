terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.0"
}
provider "aws" {
  region = "ap-south-2"
}

data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/noble/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_instance" "demo" {
  ami           = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = var.instance_type
  tags = {
    Name = var.name
  }
}
