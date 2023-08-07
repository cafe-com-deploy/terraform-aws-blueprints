output "zone_id" {
  description = "The ID of the zone"
  value = aws_route53_zone.default.zone_id  
}

output "zone_ns" {
  description = "The NS of the zone"
  value = aws_route53_zone.default.name_servers  
}
