output "region_az_alt_code_maps" {
  description = <<-EOT
    Collection of maps converting between official AWS Region, Availability Zone, and Local Zone codes and shorter unofficial codes using only lower case letters and digits. Inspired for use in naming and tagging so that region or AZ code will be 1 semantic unit.

    - `to_fixed` = Map of regions to 3-character codes and Availability Zones to 4-character codes
    - `to_short` = Map of regions and Availability Zones to compact (usually 4-6 characters) codes
    - `from_fixed` = Map of `fixed` codes back to full region or Availability Zone codes
    - `from_short` = Map of `short` codes back to full region or Availability Zone codes
    - `identity` = Identity map of full region and Availability Zone codes back to themselves
    EOT
  value = {
    to_fixed   = local.to_fixed
    to_short   = local.to_short
    from_fixed = local.from_fixed
    from_short = local.from_short
    identity   = local.identity
  }
}

output "region_display_name_map" {
  description = <<-EOT
    Map of full region names to user-friendly display names (e.g. "eu-west-3" = "Europe (Paris)").
    EOT
  value       = local.to_display_name
}

output "elb_logging_account" {
  description = "Map of full region to ELB logging account"
  value       = local.elb_logging_account
}

output "elb_logging_s3_bucket_policy_json" {
  description = <<-EOT
    The S3 bucket policy (in JSON) to attach to the S3 bucket to allow Load Balancer logs to be added.
    Requires `elb_logging_bucket_resource_arn` and `elb_logging_region` inputs.
    EOT
  value = join("",
    data.aws_iam_policy_document.by_account.*.json,
    data.aws_iam_policy_document.by_region.*.json,
  )
}

output "enabled_regions" {
  description = "A list of regions that are enabled in the account"
  value       = setunion(data.aws_regions.default.names, data.aws_regions.opted_in.names)
}

output "disabled_regions" {
  description = "A list of regions that are disabled in the account"
  value       = data.aws_regions.not_opted_in.names
}

output "all_regions" {
  description = "A list of all regions regardless of availability to the account"
  value       = data.aws_regions.complete.names
}

