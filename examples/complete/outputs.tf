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

output "identity_size" {
  description = "Size of identity map"
  value       = local.identity_size
}

output "to_short_size" {
  description = "Size of to_short map"
  value       = local.to_short_size
}

output "to_fixed_size" {
  description = "Size of to_fixed map"
  value       = local.to_fixed_size
}

output "from_short_size" {
  description = "Size of from_short map"
  value       = local.from_short_size
}

output "from_fixed_size" {
  description = "Size of from_fixed map"
  value       = local.from_fixed_size
}

output "fixed_round_trip" {
  description = "Configured region mapped to fixed code and back"
  value       = local.code_maps.from_fixed[local.code_maps.to_fixed[var.region]]
}

output "short_round_trip" {
  description = "Configured region mapped to short code"
  value       = local.code_maps.from_short[local.code_maps.to_short[var.region]]
}

output "enabled_regions" {
  description = "A list of regions that are enabled in the account"
  value       = module.example.enabled_regions
}

output "disabled_regions" {
  description = "A list of regions that are disabled in the account"
  value       = module.example.disabled_regions
}
