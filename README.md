# AWS Blueprints

## Network

Create a basic structure with VPC, 2 AZs, Route53, ACM and Application LoadBalancer;


### Usage

```
module "network" {
  source = "cafe-com-deploy/blueprints/aws//network"
  region = local.region
  tags   = local.tags
  domain_name = local.domain_name
  environment = local.environment
  balancer = {
    name = "my-domain-balancer"
  }
}
```