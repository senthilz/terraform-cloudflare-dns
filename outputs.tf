output "dns_records" {
  description = "Map of created DNS records"
  value       = cloudflare_dns_record.this
}

output "zone_id" {
  description = "The Cloudflare zone ID"
  value       = data.cloudflare_zone.this.id
  sensitive   = true
}

output "zone_name" {
  description = "The Cloudflare zone name"
  value       = data.cloudflare_zone.this.name
}

output "record_ids" {
  description = "Map of DNS record IDs"
  value       = { for k, v in cloudflare_dns_record.this : k => v.id }
  sensitive   = true
}

output "record_names" {
  description = "Map of DNS record names"
  value       = { for k, v in cloudflare_dns_record.this : k => v.hostname }
}
