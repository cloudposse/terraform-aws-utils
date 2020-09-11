output "region" {
  description = "Configured region"
  value       = var.region
}

output "fixed" {
  description = "Configured region mapped to fixed code"
  value       = local.code_maps.to_fixed[var.region]
}

output "short" {
  description = "Configured region mapped to short code"
  value       = local.code_maps.to_short[var.region]
}

output "fixed_round_trip" {
  description = "Configured region mapped to fixed code and back"
  value       = local.code_maps.from_fixed[local.code_maps.to_fixed[var.region]]
}

output "short_round_trip" {
  description = "Configured region mapped to short code"
  value       = local.code_maps.from_short[local.code_maps.to_short[var.region]]
}

