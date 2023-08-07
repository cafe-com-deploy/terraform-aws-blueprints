variable "environment" {
  description = "(Required) The environment name"
  type        = string
}

variable "tags" {
  description = "(Optional) Key-value mapping of resource tags"
  type        = map(string)
  default     = {}
}

variable "name" {
  type        = string
  description = "(Required) ALB Name"
}

variable "vpc_id" {
  description = "(Required) VPC-Id to create ALB Security Group"
  type        = string
}

variable "private" {
  type = object({
    subnets = list(string)
  })
  default = null
  description = <<EOT
    (Optional) Define private resources to internal ALB
    private = {
      subnets : "(Required) list of private subnets"
    }
  EOT
}

variable "public" {
  type = object({
    subnets = list(string)
    ssl = object({
      certificate_arn = string
      ssl_policy      = string
    })
  })
  default = null
  description = <<EOT
    (Optional) Define public resources to internal ALB
    public = {
      subnets : "(Required) list of public subnets"
      ssl = {
        certificate_arn : "(Required) SSL Certificate ARN to HTTPS access"
        ssl_policy: "(Required) Name of the SSL Policy for the listener."
      }
    }
  EOT
}
