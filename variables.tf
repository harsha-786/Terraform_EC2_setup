variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


# CIDR block allowed to SSH
variable "ssh_ingress_cidr" {
  description = "CIDR allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}

# Name for key pair
variable "key_pair_name" {
  description = "Name of the AWS key pair"
  type        = string
  default     = "harsha-key"
}

