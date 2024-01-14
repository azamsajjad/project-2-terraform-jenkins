variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "us_availability_zone" {}
variable "cidr_private_subnet" {}

output "devops_project_1_vpc_id" {
    value = aws_vpc.devops_project_1_us_east_1.id
}
output "devops_project_1_public_subnets" {
    value = aws_subnet.devops_project_1_public_subnets.*.id
}
output "devops_project_1_public_subnet_cidr_block" {
    value = aws_subnet.devops_project_1_public_subnets.*.cidr_block
}
# setup VPC
resource "aws_vpc" "devops_project_1_us_east_1" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }
}

# Setup public subnet
resource "aws_subnet" "devops_project_1_public_subnets" {
    count      = length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.devops_project_1_us_east_1.id
  
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "devops-project-tf-jenkins-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "devops_project_1_private_subnets" {
    count = length(var.cidr_private_subnet)
    vpc_id = aws_vpc.devops_project_1_us_east_1.id
    
    cidr_block = element(var.cidr_private_subnet, count.index)
    availability_zone = element(var.us_availability_zone, count.index)
    tags = {
    Name = "devops-project-tf-jenkins-private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "devops_project_1_public_igw" {
     vpc_id = aws_vpc.devops_project_1_us_east_1.id


  tags = {
    Name = "devops-project-tf-jenkins-igw"
  }
}

# public route table
resource "aws_route_table" "devops_project_1_public_route_table" {
  vpc_id = aws_vpc.devops_project_1_us_east_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_project_1_public_igw.id
  }
  tags = {
    Name = "devops-project-tf-jenkins-publicRT"
  }
}
# private route table
resource "aws_route_table" "devops_project_1_private_route_table" {
  vpc_id = aws_vpc.devops_project_1_us_east_1.id
  tags = {
    Name = "devops-project-tf-jenkins-privateRT"
  }
}
# public route table and subnet Association
resource "aws_route_table_association" "devops_project_1_public_route_table_association" {
  count = length(aws_subnet.devops_project_1_public_subnets)
  subnet_id      = aws_subnet.devops_project_1_public_subnets[count.index].id
  route_table_id = aws_route_table.devops_project_1_public_route_table.id
}
# private route table and subnet Association
resource "aws_route_table_association" "devops_project_1_private_route_table_association" {
  count = length(aws_subnet.devops_project_1_private_subnets)
  subnet_id      = aws_subnet.devops_project_1_private_subnets[count.index].id
  route_table_id = aws_route_table.devops_project_1_private_route_table.id
}