variable "lb_name" {}
variable "lb_type" {}
variable "internal_facing" { default = false }
variable "sg_ssh_http_https" {}
variable "subnet_ids" {}
variable "tag_name" {}
variable "lb_target_group_arn" {}
variable "ec2_instance_id" {}
variable "lb_listener_port_http" {}
variable "lb_listener_protocol_http" {}
variable "lb_listener_default_action" {}
variable "lb_listener_port_https" {}
variable "lb_listener_protocol_https" {}
variable "devops_project_1_acm_arn" {}
variable "lb_target_group_attachment_port" {}


output "aws_lb_dns_name" {
  value = aws_lb.devops_project_1_lb.dns_name
}

output "aws_lb_zone_id" {
  value = aws_lb.devops_project_1_lb.zone_id
}



resource "aws_lb" "devops_project_1_lb" {
    name = var.lb_name
    internal = var.internal_facing
    load_balancer_type = var.lb_type
    security_groups = [var.sg_ssh_http_https]
    subnets = var.subnet_ids
    enable_deletion_protection = false
    tags = {
        Name = var.tag_name
    }
}

resource "aws_lb_target_group_attachment" "devops_project_1_lb_target_group_attachment" {
  target_group_arn = var.lb_target_group_arn
  target_id        = var.ec2_instance_id
  port             = var.lb_target_group_attachment_port
}


resource "aws_lb_listener" "devops_project_1_lb_listener" {
  load_balancer_arn = aws_lb.devops_project_1_lb.arn
  port              = var.lb_listener_port_http
  protocol          = var.lb_listener_protocol_http

  default_action {
    type             = "forward"
    target_group_arn = var.lb_target_group_arn
  }
}


resource "aws_lb_listener" "devops_project_1_lb_listener_https" {
  load_balancer_arn = aws_lb.devops_project_1_lb.arn
  port              = var.lb_listener_port_https
  protocol          = var.lb_listener_protocol_https
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.devops_project_1_acm_arn


  default_action {
    type             = var.lb_listener_default_action
    target_group_arn = var.lb_target_group_arn
  }
}