terraform {
  backend "s3" {
    bucket = "serverbucket1"
    key    = "avi/backendbucket"
    region = "ap-south-1"
  }
}



provider "aws" {
    region = "ap-south-1"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "my-vpc"
  cidr = var.vpn_cidr_block

  azs             = [var.avail_zone]
  public_subnets  = [var.subnet_cidr_block]


  tags = {
    Name: "${var.env_prefix}-vpc" 
  }

  public_subnet_tags = {
      Name = "${var.env_prefix}-subnet" 
  }
}





module "myapp-server" {
    source = "./modules/webserver"
    vpc_id = module.vpc.vpc_id
    my_ip = var.my_ip
    env_prefix = var.env_prefix
    image_name = var.image_name
    instance_type = var.instance_type
    subnet_id = module.vpc.public_subnets[0]
    avail_zone = var.avail_zone


}


/*resource "aws_route_table" "myapp-route-table" {
    vpc_id = aws_vpc.myapp-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id
    }

    tags = {
        Name: "${var.env_prefix}-rt"
    }
}*/




/*resource "aws_route_table_association" "rt-associate" {
    subnet_id = aws_subnet.dev-subnet-1.id
    route_table_id =  aws_route_table.myapp-route-table.id
}*/








# resource "aws_key_pair" "ssh-key" {
#     key_name = "Server-key"
#     public_key = "${file(var.public_key_location)}"
# }








