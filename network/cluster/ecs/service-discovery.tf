resource "aws_service_discovery_private_dns_namespace" "namespace" {
  count       = var.service_discovery != null ? 1 : 0
  name        = var.service_discovery.domain
  description = "${var.service_discovery.domain} Service Discovery"
  vpc         = var.service_discovery.vpc_id
}
