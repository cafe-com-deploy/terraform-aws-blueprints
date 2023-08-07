resource "aws_route53_zone" "default" {  
  name = var.zone_name
  tags = var.tags
}
