variable "resource_group_name" {
  description = "name of rg"
  type        = string
}

variable "location" {
  description = "value"
  type        = string
  default     = "West US"
}

variable "vnetname" {
  description = "name of app"
  type        = string
}

variable "vnetaddressspace" {
  description = "vnet address"
  type        = string
}