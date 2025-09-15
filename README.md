## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.this](https://registry.terraform.io/providers/hashicorp/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_zone.this](https://registry.terraform.io/providers/hashicorp/cloudflare/latest/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_overwrite"></a> [allow\_overwrite](#input\_allow\_overwrite) | Allow creation of this record in Terraform to overwrite an existing record, if any | `bool` | `false` | no |
| <a name="input_dns_records"></a> [dns\_records](#input\_dns\_records) | List of DNS records to create with optional settings | <pre>list(object({<br/>    name     = string<br/>    type     = string<br/>    value    = string<br/>    ttl      = optional(number, 1)<br/>    priority = optional(number)<br/>    proxied  = optional(bool, false)<br/>    comment  = optional(string)<br/>    tags     = optional(list(string))<br/>    settings = optional(object({<br/>      flatten_cname = optional(bool)<br/>      ipv4_only     = optional(bool)<br/>      ipv6_only     = optional(bool)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The name of the Cloudflare zone to manage DNS records in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_records"></a> [dns\_records](#output\_dns\_records) | Map of created DNS records |
| <a name="output_record_ids"></a> [record\_ids](#output\_record\_ids) | Map of DNS record IDs |
| <a name="output_record_names"></a> [record\_names](#output\_record\_names) | Map of DNS record names |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The Cloudflare zone ID |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | The Cloudflare zone name |
