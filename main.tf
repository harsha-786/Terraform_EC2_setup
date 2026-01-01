provider "aws" {

    region = var.aws_region
}


data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#ssh key pair

locals {
  public_key_path = "${pathexpand("~/.ssh/harsha-key.pub")}"
}

resource "aws_key_pair" "harsha" {
  key_name   = var.key_pair_name
  public_key = file(local.public_key_path)
}

#security group for SSH into ec2 instance
resource "aws_security_group" "ec2_sgroup" {
  name        = "ec2_SSH_sgroup"
  description = "Allow SSH traffic"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2_SSH_sgroup"
  }
}

#get default vpc
data "aws_vpc" "default" {
  default = true
}

#use default subnet in that vpc
data "aws_subnets" "az_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  
filter {
    name   = "availability-zone"
    values = ["ap-south-1a"] 
  }
}


resource "aws_instance" "instance_one" {
    ami = "ami-0e306788ff2473ccb"
    instance_type = var.instance_type
    key_name = aws_key_pair.harsha.key_name
    subnet_id = data.aws_subnets.az_a.ids[0]
    vpc_security_group_ids = [aws_security_group.ec2_sgroup.id]
    associate_public_ip_address = true
    tags = {
        Name = "myinstance_one"
    }

}