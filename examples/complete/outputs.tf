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

output "all_regions" {
  description = "A list of regions that are available to the account"
  value       = module.example.all_regions
}

output "elb_logging_s3_bucket_policy_json" {
  description = <<-EOT
    The S3 bucket policy (in JSON) to attach to the S3 bucket to allow Load Balancer logs to be added.
    Requires `elb_logging_bucket_resource_arn` and `elb_logging_region` inputs.
    EOT
  value       = module.example.elb_logging_s3_bucket_policy_json
}

output "region_az_alt_code_maps" {
  description = <<-EOT
    Collection of maps converting between official AWS Region, Availability Zone, and Local Zone codes and shorter unofficial codes using only lower case letters and digits. Inspired for use in naming and tagging so that region or AZ code will be 1 semantic unit.

    - `to_fixed` = Map of regions to 3-character codes and Availability Zones to 4-character codes
    - `to_short` = Map of regions and Availability Zones to compact (usually 4-6 characters) codes
    - `from_fixed` = Map of `fixed` codes back to full region or Availability Zone codes
    - `from_short` = Map of `short` codes back to full region or Availability Zone codes
    - `identity` = Identity map of full region and Availability Zone codes back to themselves
    EOT
  value       = module.example.region_az_alt_code_maps
}

output "region_display_name_map" {
  description = <<-EOT
    Map of full region names to user-friendly display names (e.g. "eu-west-3" = "Europe (Paris)").
    EOT
  value       = module.example.region_display_name_map
}
