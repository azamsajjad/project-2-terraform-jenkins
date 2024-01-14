module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  cidr_private_subnet  = var.cidr_private_subnet
  us_availability_zone = var.us_availability_zone
}

module "security_group" {
  source              = "./security-groups"
  ec2_sg_name         = "SG for EC2 to enable 22,80,443"
  vpc_id              = module.networking.devops_project_1_vpc_id
  ec2_sg_jenkins_name = "SG for EC2 to enable 8080"
}

module "jenkins" {
  source                    = "./jenkins"
  ami_image_name            = var.ami_image_name
  ami_owner_name            = var.ami_owner_name
  instance_type             = "t2.medium"
  tag_name                  = "Jenkins:Ubuntu Linux EC2"
  subnet_id                 = tolist(module.networking.devops_project_1_public_subnets)[0]
  sg_for_jenkins            = [module.security_group.ec2_sg_id_ssh_http_s, module.security_group.ec2_sg_jenkins_id]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./jenkins-script/tf-jenkins-installer.sh", {})
  public_key                = var.public_key
}

module "target_group" {
  source                   = "./target-group"
  lb_target_group_name     = "jenkins-lb-target-group"
  lb_target_group_port     = 8080
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.devops_project_1_vpc_id
  ec2_instance_id          = module.jenkins.jenkins_ec2_id

}

module "alb" {
  source                          = "./alb"
  lb_name                         = "devops-project-1-alb"
  lb_type                         = "application"
  internal_facing                 = false
  sg_ssh_http_https               = module.security_group.ec2_sg_id_ssh_http_s
  subnet_ids                      = tolist(module.networking.devops_project_1_public_subnets)
  tag_name                        = "devops-project-tf-jenkins-lb"
  lb_target_group_arn             = module.target_group.devops_project_1_lb_target_group_arn
  ec2_instance_id                 = module.jenkins.jenkins_ec2_id
  lb_listener_port_http            = 80
  lb_listener_protocol_http        = "HTTP"
  lb_listener_default_action       = "forward"
  lb_listener_port_https           = 443
  lb_listener_protocol_https       = "HTTPS"
  devops_project_1_acm_arn        = module.aws_certificate_manager.devops_project_1_acm_arn
  lb_target_group_attachment_port = 8080
}

module "hosted_zone_route53" {
  source          = "./hosted-zone"
  domain_name     = "jenkins.azamsajjad.com"
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id  = module.alb.aws_lb_zone_id

}

module "aws_certificate_manager" {
  source         = "./certificate-manager"
  domain_name    = "jenkins.azamsajjad.com"
  hosted_zone_id = module.hosted_zone_route53.hosted_zone_id
}