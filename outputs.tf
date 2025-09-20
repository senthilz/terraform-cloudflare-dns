output "dns_records" {
  description = "Map of created DNS records"
  value       = cloudflare_dns_record.this
}

output "record_ids" {
  description = "Map of DNS record IDs"
  value       = { for k, v in cloudflare_dns_record.this : k => v.id }
  sensitive   = true
}

output "record_names" {
  description = "Map of DNS record names"
  value       = { for k, v in cloudflare_dns_record.this : k => v.name }
}
