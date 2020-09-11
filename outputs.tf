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
