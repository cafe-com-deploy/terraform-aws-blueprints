resource "aws_route53_record" "record_validate" {
  for_each = {
    for dvo in aws_acm_certificate.domain.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if var.zone_id != null
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "validation" {
  count                   = length(aws_route53_record.record_validate) > 0 ? 1 : 0
  certificate_arn         = aws_acm_certificate.domain.arn
  validation_record_fqdns = aws_route53_record.record_validate[*].fqdn
}
