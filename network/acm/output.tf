output "arn" {
  value = aws_acm_certificate.domain.arn
}

output "domain_name" {
  value = aws_acm_certificate.domain.domain_name
}

output "domain_validation_options" {
  value = aws_acm_certificate.domain.domain_validation_options
}

output "record_validate" {
  value = aws_route53_record.record_validate
}