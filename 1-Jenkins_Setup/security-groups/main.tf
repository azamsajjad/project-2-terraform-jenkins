variable "ec2_sg_name" {}
variable "vpc_id"{}
variable "ec2_sg_jenkins_name" {}



output "ec2_sg_id_ssh_http_s" {
    value = aws_security_group.devops_project_1_ec2_sg.id
}
output "ec2_sg_jenkins_id" {
    value = aws_security_group.devops_project_1_ec2_sg_jenkins.id
}

locals {
    ingress = [
    {
        port = 22
        description = "ssh"
    },
    {
        port = 80
        description = "http"
    },
    {
        port = 443
        description = "https"
    }
    ]
}


resource "aws_security_group" "devops_project_1_ec2_sg" {
  name        = var.ec2_sg_name
  description = "Allow Port 22,80,443 inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.ingress
    content {
        description = ingress.value.description
        from_port = ingress.value.port
        to_port = ingress.value.port
        protocol = "tcp"
        security_groups = []
        self = false
        cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow Port 22,80,443 inbound traffic and all outbound traffic"
  }
}


resource "aws_security_group" "devops_project_1_ec2_sg_jenkins" {
  name        = var.ec2_sg_jenkins_name
  description = "Allow Port 8080 inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description = "allow 8080 for jenkins"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "Security Groups to allow 8080"
    }
}