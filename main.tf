resource "cloudflare_dns_record" "this" {
  for_each = { for idx, record in var.dns_records : idx => record }

  zone_id         = var.zone_id
  name            = each.value.name
  type            = each.value.type
  content         = each.value.content
  ttl             = lookup(each.value, "ttl", 1)
  priority        = lookup(each.value, "priority", null)
  proxied         = lookup(each.value, "proxied", false)
  comment         = lookup(each.value, "comment", null)
  tags            = lookup(each.value, "tags", null)
}
