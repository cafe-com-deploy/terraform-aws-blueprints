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
  description = "(Required) Cluster Name"
}

variable "enable_container_insights" {
  description = "(Optional) Turn on container insights. Default is False."
  type = bool
  default = false
}

variable "capacity_providers" {
  description = "(Optional) Capacity providers. Default is FARGATE."
  type = list(string)
  default = ["FARGATE", "FARGATE_SPOT"]
}

variable "retention_in_days" {
  description = "(Optional) Log retention in days. Default is 30."
  type = number
  default = 30
}

variable "service_discovery" {
  type = object({
    domain = string
    vpc_id = string
  })
  default = null
  description = <<EOT
  (Optional) Service discovery options.
  service_discovery = {
    domain : "(Required) The name of the namespace. Example: mydomain.corp"
    vpc_id : "(Required) The ID of VPC that you want to associate the namespace with."
  }
  EOT
}