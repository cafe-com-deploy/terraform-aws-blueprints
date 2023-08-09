output "arn" {
  value = aws_ecs_cluster.default.arn
}

output "id" {
  value = aws_ecs_cluster.default.id
}

output "name" {
  value = aws_ecs_cluster.default.name
}

output "namespace" {
  value = var.service_discovery != null ? aws_service_discovery_private_dns_namespace.namespace.0.id : null
}
