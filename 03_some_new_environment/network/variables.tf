variable "location" {
  type        = string
  description = "Azure region to use."
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Environment to deploy (dev, test, prod)."
  default     = "dev2"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the virtual network."
  default     = "10.10.0.0/16"
}

variable "subnet_prefixes" {
  type        = map(string)
  description = "Map of CIDR blocks for the subnets."

  default = {
    aks = "10.10.0.0/24"
  }
}
