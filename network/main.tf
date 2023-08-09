
module "vpc" {
  count  = var.vpc.enabled ? 1 : 0
  source = "./vpc"

  region      = var.region
  zones       = var.vpc.zones
  environment = var.environment
  tags        = var.tags
}

module "certificate" {
  count                     = var.certificate.enabled ? 1 : 0
  source                    = "./acm"
  domain_name               = var.domain_name
  subject_alternative_names = length(var.certificate.subject_alternative_names) > 0 ? var.certificate.subject_alternative_names : ["*.${var.domain_name}"]

  environment = var.environment
  tags        = var.tags
}

module "route53" {
  count     = var.route53.enabled ? 1 : 0
  source    = "./route53"
  zone_name = var.domain_name
  tags      = var.tags
}

module "balancer" {
  count  = var.balancer.enabled ? 1 : 0
  source = "./balancer/application"

  name   = var.balancer.name
  vpc_id = var.vpc.enabled ? module.vpc[0].vpc_id : var.vpc.imports.vpc_id

  private = var.balancer.enable_private ? {
    subnets = var.vpc.enabled ? module.vpc[0].private_subnets : var.vpc.imports.private_subnets
  } : null

  public = var.balancer.enable_public ? {
    subnets = var.vpc.enabled ? module.vpc[0].public_subnets : var.vpc.imports.public_subnets
    ssl = {
      certificate_arn = var.certificate.enabled ? module.certificate[0].arn : var.certificate.imports.arn
      ssl_policy      = var.balancer.ssl_policy
    }
  } : null

  environment = var.environment
  tags        = var.tags
}

module "cluster_ecs" {
  count  = var.cluster_ecs.enabled ? 1 : 0
  source = "./cluster/ecs"

  name                      = var.cluster_ecs.name
  enable_container_insights = var.cluster_ecs.enable_container_insights
  capacity_providers        = var.cluster_ecs.capacity_providers
  retention_in_days         = var.cluster_ecs.retention_in_days

  service_discovery = var.cluster_ecs.enable_service_discovery ? {
    domain = var.cluster_ecs.internal_domain
    vpc_id = var.vpc.enabled ? module.vpc[0].vpc_id : var.vpc.imports.vpc_id
  } : null

  environment = var.environment
  tags        = var.tags
}
