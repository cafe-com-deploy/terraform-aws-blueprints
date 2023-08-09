output "vpc" {
  description = "Module VPC outputs"
  value = var.vpc.enabled ? module.vpc[0] : null
}

output "certificate" {
  description = "Module ACM outputs"
  value = var.certificate.enabled ? module.certificate[0] : null
}

output "route53" {
  description = "Module Route53 outputs"
  value = var.route53.enabled ? module.route53[0] : null
}

output "balancer" {
  description = "Module ALB outputs"
  value = var.balancer.enabled ? module.balancer[0] : null
}

output "cluster_ecs" {
  description = "Module ECS outputs"
  value = var.cluster_ecs.enabled ? module.cluster_ecs[0] : null
}
