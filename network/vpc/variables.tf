variable "zones" {
  type = list(object({
    az                  = string
    private_subnet_cidr = string
    public_subnet_cidr  = string
  }))
  description = <<EOT
    zones = [{
        az : "Character of availability zone (a, b, c or d)"
        private_subnet_cidr: "Network mask of private subnet"
        public_subnet_cidr: "Network mask of public subnet"
    }]
  EOT
}

variable "region" {
  description = "Region to create vpc and subnets"
  type = string
}

variable "environment" {
  description = "Environment name Ex: (dev, prd, qa)"
  type        = string
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
}
