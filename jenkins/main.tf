variable "ami_owner_name" {}
variable "ami_image_name"{}
variable "instance_type"{}
variable "tag_name"{}
variable "subnet_id"{}
variable "sg_for_jenkins"{}
variable "enable_public_ip_address"{}
variable "user_data_install_jenkins"{}
variable "public_key"{}

output "jenkins_ec2_public_ip" {
    value = aws_instance.jenkins_ec2_instance.public_ip
}
output "jenkins_ec2_id" {
    value = aws_instance.jenkins_ec2_instance.id
}
output "connection_string_for_ssh" {
    value = format("%s%s", "ssh -i /home/devops/.ssh/jenkins_key ubuntu@", aws_instance.jenkins_ec2_instance.public_ip)
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["${var.ami_owner_name}"]
    filter {
    name   = "name"
    values = ["${var.ami_image_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

resource "aws_instance" "jenkins_ec2_instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    tags = {
        Name = var.tag_name
    }
    key_name = "jenkins_key"
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.sg_for_jenkins
    associate_public_ip_address = var.enable_public_ip_address
    user_data = var.user_data_install_jenkins
    metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}


resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
    key_name = "jenkins_key"
    public_key = var.public_key
}