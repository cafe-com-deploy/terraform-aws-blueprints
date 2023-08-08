module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name    = "vpc-${var.region}-${var.environment}"

  azs             = var.zones[*].az
  private_subnets = var.zones[*].private_subnet_cidr
  public_subnets  = var.zones[*].public_subnet_cidr

  enable_nat_gateway   = true
  single_nat_gateway   = true
  reuse_nat_ips        = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = var.tags
}
