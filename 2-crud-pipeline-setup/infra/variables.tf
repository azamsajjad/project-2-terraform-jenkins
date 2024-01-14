variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
}

variable "vpc_name" {
  type        = string
  description = "DevOps Project 1 VPC 1"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "us_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}
variable "public_key" {
  type        = string
  description = "DevOps Project tf-jenkins Public key for EC2 instance"
}

variable "ami_image_name" {
  type = string
}
variable "ami_owner_name" {
  type = string
}



# variable "bucket_name" {
#   type        = string
#   description = "Remote state bucket name"
# }

# variable "name" {
#   type        = string
#   description = "Tag name"
# }

# variable "environment" {
#   type        = string
#   description = "Environment name"
# }



variable "domain_name" {
  type = string
  description = "Name of the domain"
}