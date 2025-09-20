variable "zone_id" {
  description = "The id of the cloudflare zone to manage DNS records in"
  type        = string
  validation {
    condition     = length(var.zone_name) > 0
    error_message = "Zone id cannot be empty."
  }
}

variable "dns_records" {
  description = "List of DNS records to create with optional settings"
  type = list(object({
    name     = string
    type     = string
    content  = string
    ttl      = optional(number, 1)
    priority = optional(number)
    proxied  = optional(bool, false)
    comment  = optional(string)
    tags     = optional(list(string))
  }))
  default = []

  validation {
    condition = alltrue([
      for record in var.dns_records : contains([
        "A", "AAAA", "CNAME", "MX", "NS", "OPENPGPKEY", "PTR", "TXT",
        "CAA", "CERT", "DNSKEY", "DS", "HTTPS", "LOC", "NAPTR",
        "SMIMEA", "SRV", "SSHFP", "SVCB", "TLSA", "URI"
      ], upper(record.type))
    ])
    error_message = "DNS record type must be one of the supported Cloudflare record types: A, AAAA, CNAME, MX, NS, OPENPGPKEY, PTR, TXT, CAA, CERT, DNSKEY, DS, HTTPS, LOC, NAPTR, SMIMEA, SRV, SSHFP, SVCB, TLSA, URI."
  }

  validation {
    condition = alltrue([
      for record in var.dns_records :
      record.settings == null ? true : (
        # flatten_cname cannot be used with proxied records
        (lookup(record.settings, "flatten_cname", null) == null || record.proxied != true) &&
        # ipv4_only and ipv6_only require proxied records
        (lookup(record.settings, "ipv4_only", null) == null || record.proxied == true) &&
        (lookup(record.settings, "ipv6_only", null) == null || record.proxied == true) &&
        # ipv4_only and ipv6_only are mutually exclusive
        (lookup(record.settings, "ipv4_only", null) != true || lookup(record.settings, "ipv6_only", null) != true)
      )
    ])
    error_message = "Invalid settings combination: flatten_cname cannot be used with proxied records; ipv4_only/ipv6_only require proxied records and are mutually exclusive."
  }
}

variable "allow_overwrite" {
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any"
  type        = bool
  default     = false
}
