locals {

  segment_id_list = [ for v in data.alkira_segment.service : v.id ]

}

data "alkira_segment" "service" {
  for_each = toset(var.segments)
  name     = each.key
}

data "alkira_list_global_cidr" "cidr" {
  name = var.global_cidr
}

resource "alkira_service_infoblox" "service" {

  # service 
  name                    = var.name
  cxp                     = var.cxp
  global_cidr_list_id     = data.alkira_list_global_cidr.cidr.id
  segment_ids             = local.segment_id_list
  license_type            = var.license_type
  service_group_name      = var.service_group_name
  shared_secret           = var.shared_secret

  anycast {
    enabled      = var.anycast.enabled
    backup_cxps  = var.anycast.backup_cxps
    ips          = var.anycast.ips
  }

  grid_master {
    name      = var.grid_master.name
    ip        = var.grid_master.ip
    username  = var.grid_master.username
    password  = var.grid_master.password
    external  = var.grid_master.external
  }

  # handle nested schema for instances 
  dynamic "instance" {
    for_each = {
      for o in var.instances : o.hostname => o
    }

    content {
      hostname  = instance.value.hostname
      model     = instance.value.model
      password  = instance.value.password
      type      = instance.value.type
      version   = instance.value.version
    }
  }

}