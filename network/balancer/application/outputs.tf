output "arn" {
  value = aws_lb.default.arn
}

output "dns_name" {
  value = aws_lb.default.dns_name
}

output "zone_id" {
  value = aws_lb.default.zone_id
}

output "private_listener_arn" {
  value = var.private != null ? aws_lb_listener.private[0].arn : null
}

output "public_listener_arn" {
  value = var.public != null ? aws_lb_listener.public[0].arn : null
}

output "security_group_id" {
  value = aws_security_group.default.arn
}