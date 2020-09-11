output "to_fixed" {
  description = "Map of regions to 3-character codes and Availability Zones to 4-character codes"
  value       = local.to_fixed
}

output "to_short" {
  description = "Map of regions and Availability Zones to compact (4-6 characters) codes without hyphens"
  value       = local.to_short
}

output "from_fixed" {
  description = "Map of `fixed` codes to full region or Availability Zone codes"
  value       = local.from_fixed
}

output "from_short" {
  description = "Map of `short` codes to full region or Availability Zone codes"
  value       = local.from_short
}

