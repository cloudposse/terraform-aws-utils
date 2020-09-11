output "region" {
  description = "Configured region"
  value       = var.region
}

output "fixed" {
  description = "Map region to fixed"
  value       = module.example.to_fixed[var.region]
}

output "short" {
  description = "Map region to short"
  value       = module.example.to_short[var.region]
}

output "fixed_round_trip" {
  description = "Map region to fixed and back"
  value       = module.example.from_fixed[module.example.to_fixed[var.region]]
}

output "short_round_trip" {
  description = "Map region to short and back"
  value       = module.example.from_short[module.example.to_short[var.region]]
}

