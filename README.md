# Alkira Service Infoblox - Terraform Module
This module makes it easy to provision Infoblox service in Alkira.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_alkira"></a> [alkira](#requirement\_alkira) | >= 0.9.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alkira"></a> [alkira](#provider\_alkira) | >= 0.9.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alkira_service_infoblox.service](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/resources/service_infoblox) | resource |
| [alkira_list_global_cidr.cidr](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/list_global_cidr) | data source |
| [alkira_segment.service](https://registry.terraform.io/providers/alkiranet/alkira/latest/docs/data-sources/segment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anycast"></a> [anycast](#input\_anycast) | Anycast policy to be used with service | <pre>object({<br>    enabled     = optional(bool, false)<br>    backup_cxps = optional(list(string))<br>    ips         = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_cxp"></a> [cxp](#input\_cxp) | Alkira CXP to provision service in | `string` | n/a | yes |
| <a name="input_global_cidr"></a> [global\_cidr](#input\_global\_cidr) | Global CIDR must exist with a dedicated /25 subnet, per CXP | `string` | n/a | yes |
| <a name="input_grid_master"></a> [grid\_master](#input\_grid\_master) | Configuration for Infoblox grid master | <pre>object({<br>    external  = optional(bool, true)<br>    ip        = optional(string)<br>    name      = string<br>    username  = string<br>    password  = string<br>  })</pre> | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | Configuration for instances of service | <pre>list(object({<br>    anycast_enabled  = optional(bool, false)<br>    hostname         = string<br>    password         = string<br>    model            = optional(string, "TE-V1425")<br>    type             = optional(string, "MEMBER")<br>    version          = optional(string, "8.5.2")<br>  }))</pre> | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Only BYOL is supported today. Alkira deploys the service using a temp license with a 60 day timeout.<br>  Once deployed, you must activate via the Infoblox portal before the temp license expires. | `string` | `"BRING_YOUR_OWN"` | no |
| <a name="input_name"></a> [name](#input\_name) | Service name | `string` | n/a | yes |
| <a name="input_segments"></a> [segments](#input\_segments) | List of segments to associate with the service | `list(string)` | n/a | yes |
| <a name="input_service_group_name"></a> [service\_group\_name](#input\_service\_group\_name) | Unique attribute per CXP used to identify all traffic to and from the service | `string` | n/a | yes |
| <a name="input_shared_secret"></a> [shared\_secret](#input\_shared\_secret) | Shared secret for Infoblox grid | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cxp"></a> [cxp](#output\_cxp) | Service cxp |
| <a name="output_id"></a> [id](#output\_id) | Service id |
<!-- END_TF_DOCS -->