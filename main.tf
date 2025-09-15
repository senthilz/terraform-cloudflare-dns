data "cloudflare_zone" "this" {
  name = var.zone_name
}

resource "cloudflare_dns_record" "this" {
  for_each = { for idx, record in var.dns_records : idx => record }

  zone_id         = data.cloudflare_zone.this.id
  name            = each.value.name
  type            = each.value.type
  value           = each.value.value
  ttl             = lookup(each.value, "ttl", 1)
  priority        = lookup(each.value, "priority", null)
  proxied         = lookup(each.value, "proxied", false)
  comment         = lookup(each.value, "comment", null)
  tags            = lookup(each.value, "tags", null)
  allow_overwrite = var.allow_overwrite

  # DNS record settings
  dynamic "settings" {
    for_each = lookup(each.value, "settings", null) != null ? [each.value.settings] : []
    content {
      flatten_cname = lookup(settings.value, "flatten_cname", null)
      ipv4_only     = lookup(settings.value, "ipv4_only", null)
      ipv6_only     = lookup(settings.value, "ipv6_only", null)
    }
  }
}
