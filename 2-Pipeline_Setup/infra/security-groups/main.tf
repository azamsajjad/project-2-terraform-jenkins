variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "public_subnet_cidr_block" {}
variable "rds_sg_name" {}
variable "ec2_sg_name_for_python_api" {}

output "devops_project_app_sg_id" {
  value = aws_security_group.devops_project_app_sg.id
}
output "devops_project_app_sg_for_rds_id" {
  value = aws_security_group.devops_project_app_sg_for_rds.id
}
output "devops_project_app_sg_for_python_id" {
  value = aws_security_group.ec2_sg_python_api.id
}

locals {
  ingress = [
    {
      port        = 22
      description = "ssh port"
    },
    {
      port        = 80
      description = "http port"
    },
    {
      port        = 443
      description = "https port"
    }
  ]
}

resource "aws_security_group" "devops_project_app_sg" {
  name        = var.ec2_sg_name
  description = "Allow 22,80,443 inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.ingress
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port       = ingress.value.port
      protocol     = "tcp"
      to_port         = ingress.value.port
      description     = ingress.value.description
      security_groups = []
      self            = false

    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow Port 22,80,443 inbound traffic and all outbound traffic"
  }
}

resource "aws_security_group" "devops_project_app_sg_for_rds" {
  name        = var.rds_sg_name
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidr_block # replace with your EC2 instance security group CIDR block
  }
}
resource "aws_security_group" "ec2_sg_python_api" {
  name        = var.ec2_sg_name_for_python_api
  description = "Enable the Port 5000 for python api"
  vpc_id      = var.vpc_id

  # ssh for terraform remote exec
  ingress {
    description = "Allow traffic on port 5000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
  }

  tags = {
    Name = "Security Groups to allow traffic on port 5000"
  }
}