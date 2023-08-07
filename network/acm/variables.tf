variable "environment" {
  description = "(Required) The environment name (dev, qa, prd)"
  type        = string
}

variable "tags" {
  description = "(Optional) Map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "(Required) Domain name for which the certificate should be issued"
  type = string
}

variable "subject_alternative_names" {
  description = "(Optional) Set of domains that should be SANs in the issued certificate. "
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "(Optional) Set zone_id to autocreate DNS validation"
  type    = string
  default = null
}
