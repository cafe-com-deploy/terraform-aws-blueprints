variable "zone_name" {
  description = "(Required) The domain name"
  type = string
}

variable "tags" {
  description = "(Optional) Key-value mapping of resource tags"
  type        = map(string)
  default     = {}
}
