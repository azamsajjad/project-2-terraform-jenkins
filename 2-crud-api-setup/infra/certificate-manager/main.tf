variable "domain_name" {}
variable "hosted_zone_id" {}



output "devops_project_1_acm_arn" {
    value = aws_acm_certificate.devops_project_1_acm.arn
}

resource "aws_acm_certificate" "devops_project_1_acm" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = "Development"
  }

  lifecycle {
    create_before_destroy = false
  }
}


resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.devops_project_1_acm.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}