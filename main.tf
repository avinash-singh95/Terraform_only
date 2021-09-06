provider "aws" {
    region = "ap-south-1"
}

variable "subnet_cidr_block" {
    description = "subnet cidr block"
}

variable "vpn_cidr_block" {
    description = "vpn cidr block"
}

variable "environment" {
    description = "deployment environment"
}


variable "avail_zone"{}

resource "aws_vpc" "development-vpc" {
     cidr_block = var.vpn_cidr_block
     tags = {
         Name: var.environment
     }
}

resource "aws_subnet" "dev-subnet-1" {
 vpc_id = aws_vpc.development-vpc.id
 cidr_block = var.subnet_cidr_block
 availability_zone = var.avail_zone
  tags = {
         Name: "subnet-dev-1"
     }
}

data "aws_vpc" "existing_vpc" {
    default = true
}


output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}


output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}