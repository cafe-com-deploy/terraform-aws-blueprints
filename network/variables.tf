variable "region" {
  description = "(Required) AWS Region."
  type        = string
}

variable "environment" {
  description = "(Required) Environment name Ex: (dev, prd, qa)"
  type        = string
}

variable "domain_name" {
  description = "(Required) Domain name associated"
  type        = string
}

variable "tags" {
  description = "(Optional) Key-value mapping of resource tags"
  type        = map(string)
  default     = {}
}

variable "vpc" {
  type = object({
    enabled = bool
    zones = optional(list(object({
      az                  = string
      private_subnet_cidr = string
      public_subnet_cidr  = string
      })),
      [
        {
          az                  = "a"
          private_subnet_cidr = "10.101.0.0/16"
          public_subnet_cidr  = "10.201.0.0/16"
        },
        {
          az                  = "b"
          private_subnet_cidr = "10.102.0.0/16"
          public_subnet_cidr  = "10.202.0.0/16"
        }
    ])
    imports = optional(object({
      vpc_id          = string
      private_subnets = list(string)
      public_subnets  = list(string)
    }))
  })
  default = {
    enabled = true
  }
}

variable "certificate" {
  type = object({
    enabled                   = bool
    subject_alternative_names = optional(list(string), [])
    imports = optional(object({
      arn = string
    }))
  })
  default = {
    enabled = true
  }
}

variable "route53" {
  type = object({
    enabled = bool
  })
  default = {
    enabled = true
  }
}

variable "balancer" {
  type = object({
    enabled        = bool
    name           = optional(string, "myorg-balancer")
    enable_private = optional(bool, false)
    enable_public  = optional(bool, true)
    ssl_policy     = optional(string, "ELBSecurityPolicy-2016-08")
  })
  default = {
    enabled = true
  }
}

variable "cluster_ecs" {
  type = object({
    enabled                   = bool
    name                      = optional(string, "myorg-cluster")
    enable_container_insights = optional(bool, false)
    capacity_providers        = optional(list(string), ["FARGATE", "FARGATE_SPOT"])
    retention_in_days         = optional(number, 30)
    enable_service_discovery  = optional(bool, false)
    internal_domain           = optional(string, "myorg.corp")
  })
  default = {
    enabled = true
  }
}
