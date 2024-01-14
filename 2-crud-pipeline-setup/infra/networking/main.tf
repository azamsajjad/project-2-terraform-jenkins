variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "us_availability_zone" {}

output "devops_project_app_vpc_id" {
  value = aws_vpc.devops_project_1_us_west_1.id
}

output "devops_project_app_public_subnets" {
  value = aws_subnet.devops_project_app_public_subnets.*.id
}
output "public_subnets_cidr_block" {
  value = aws_subnet.devops_project_app_public_subnets.*.cidr_block
}



resource "aws_vpc" "devops_project_1_us_west_1" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "devops_project_app_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.devops_project_1_us_west_1.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "devops-project-app-public-subnet-${count.index + 1}"
  }
}
resource "aws_subnet" "devops_project_app_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.devops_project_1_us_west_1.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "devops-project-app-private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "devops_project_app_igw" {
  vpc_id = aws_vpc.devops_project_1_us_west_1.id

  tags = {
    Name = "devops-project-app-igw"
  }
}

resource "aws_route_table" "devops_project_app_public_rt" {
  vpc_id = aws_vpc.devops_project_1_us_west_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_project_app_igw.id
  }

  tags = {
    Name = "devops-project-app-public-rt"
  }
}
resource "aws_route_table_association" "devops_project_app_public_rt_association" {
  count          = length(aws_subnet.devops_project_app_public_subnets)
  subnet_id      = aws_subnet.devops_project_app_public_subnets[count.index].id
  route_table_id = aws_route_table.devops_project_app_public_rt.id
}
resource "aws_route_table" "devops_project_app_private_rt" {
  vpc_id = aws_vpc.devops_project_1_us_west_1.id
  tags = {
    Name = "devops-project-app-private-rt"
  }
}
resource "aws_route_table_association" "devops_project_app_private_rt_association" {
  count          = length(aws_subnet.devops_project_app_private_subnets)
  subnet_id      = aws_subnet.devops_project_app_private_subnets[count.index].id
  route_table_id = aws_route_table.devops_project_app_private_rt.id
}