variable "name" {
  description = "Service name"
  type        = string
}

variable "cxp" {
  description = "Alkira CXP to provision service in"
  type        = string
}

variable "segments" {
  description = "List of segments to associate with the service"
  type        = list(string)
}

variable "license_type" {
  description = <<EOF
  Only BYOL is supported today. Alkira deploys the service using a temp license with a 60 day timeout.
  Once deployed, you must activate via the Infoblox portal before the temp license expires.
  EOF

  type        = string
  default     = "BRING_YOUR_OWN"
}

variable "global_cidr" {
  description = "Global CIDR must exist with a dedicated /25 subnet, per CXP"
  type        = string
}

variable "service_group_name" {
  description = "Unique attribute per CXP used to identify all traffic to and from the service"
  type        = string
}

variable "shared_secret" {
  description = "Shared secret for Infoblox grid"
  type        = string
  sensitive   = true
}

variable "anycast" {
  description = "Anycast policy to be used with service"

  type = object({
    enabled     = optional(bool, false)
    backup_cxps = optional(list(string))
    ips         = optional(list(string))
  })
  sensitive  = true
}

variable "grid_master" {
  description = "Configuration for Infoblox grid master"

  type = object({
    external  = optional(bool, true)
    ip        = optional(string)
    name      = string
    username  = string
    password  = string
  })
  sensitive  = true
}

variable "instances" {
  description = "Configuration for instances of service"

  type = list(object({
    anycast_enabled  = optional(bool, false)
    hostname         = string
    password         = string
    model            = optional(string, "TE-V1425")
    type             = optional(string, "MEMBER")
    version          = optional(string, "8.5.2")
  }))
}