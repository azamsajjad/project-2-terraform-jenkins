module "s3" {
  source      = "./s3"
  bucket_name = var.bucket_name
  name        = var.name
  environment = var.bucket_name
}  
  
module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  cidr_private_subnet  = var.cidr_private_subnet
  us_availability_zone = var.us_availability_zone
}

module "security_group" {
  source                     = "./security-groups"
  ec2_sg_name                = "devops_project_app_sg"
  vpc_id                     = module.networking.devops_project_app_vpc_id
  public_subnet_cidr_block   = tolist(module.networking.public_subnets_cidr_block)
  rds_sg_name                = "devops_project_app_sg_for_rds"
  ec2_sg_name_for_python_api = "devops_project_app_sg_for_python"
}

module "ec2" {
  source                               = "./ec2"
  ami_image_name                       = var.ami_image_name
  ami_owner_name                       = var.ami_owner_name
  instance_type                        = "t3.micro"
  tag_name                             = "App:Ubuntu Linux EC2"
  subnet_id                            = tolist(module.networking.devops_project_app_public_subnets)[0]
  devops_project_app_sg_id            = module.security_group.devops_project_app_sg_id
  devops_project_app_sg_for_python_id = module.security_group.devops_project_app_sg_for_python_id
  enable_public_ip_address             = true
  user_data_install_python             = templatefile("./template/ec2_install_python.sh", {})
  public_key                           = var.public_key
}
module "rds_db_instance" {
  source               = "./rds"
  db_subnet_group_name = "devops_project_app_rds_subnet_group"
  subnet_groups        = tolist(module.networking.devops_project_app_public_subnets)
  rds_mysql_sg_id      = module.security_group.devops_project_app_sg_for_rds_id
  mysql_db_identifier  = "mydb"
  mysql_username       = "dbuser"
  mysql_password       = "dbpassword"
  mysql_dbname         = "devprojdb"
}


module "target_group" {
  source                   = "./target-group"
  lb_target_group_name     = "jenkins-lb-target-group"
  lb_target_group_port     = 8080
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.devops_project_app_vpc_id
  ec2_instance_id          = module.ec2.ec2_id

}

module "alb" {
  source                          = "./alb"
  lb_name                         = "devops-project-1-app-alb"
  lb_type                         = "application"
  internal_facing                 = false
  sg_ssh_http_https               = module.security_group.devops_project_app_sg_id
  subnet_ids                      = tolist(module.networking.devops_project_app_public_subnets)
  tag_name                        = "devops-project-app-lb"
  lb_target_group_arn             = module.target_group.devops_project_app_lb_target_group_arn
  ec2_instance_id                 = module.ec2.ec2_id
  lb_listener_port_http            = 5000
  lb_listener_protocol_http        = "HTTP"
  lb_listener_default_action       = "forward"
  lb_listener_port_https           = 443
  lb_listener_protocol_https       = "HTTPS"
  devops_project_1_acm_arn        = module.aws_certificate_manager.devops_project_1_app_acm_arn
  lb_target_group_attachment_port = 5000
}

module "hosted_zone_route53" {
  source          = "./hosted-zone"
  domain_name     = "app.azamsajjad.com"
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id  = module.alb.aws_lb_zone_id

}

module "aws_certificate_manager" {
  source         = "./certificate-manager"
  domain_name    = "app.azamsajjad.com"
  hosted_zone_id = module.hosted_zone_route53.hosted_zone_id
}