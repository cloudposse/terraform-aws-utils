provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

module "s3_bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "3.0.0"

  context = module.this.context
}

module "example" {
  source = "../.."

  elb_logging_bucket_resource_arn = "${module.s3_bucket.bucket_arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*}"
  elb_logging_region              = var.region

  context = module.this.context
}

locals {
  code_maps = module.example.region_az_alt_code_maps

  identity_size   = length(local.code_maps.identity)
  to_short_size   = length(local.code_maps.to_short)
  to_fixed_size   = length(local.code_maps.to_fixed)
  from_fixed_size = length(local.code_maps.from_fixed)
  from_short_size = length(local.code_maps.from_short)

  # The Display Name map is generated from another source,
  # so we can check that all of its keys are in
  # one of the maps, which should ensure they are in all of the maps.
  # This should fail with a runtime error if a key is missing.
  ux_check = [for k, v in module.example.region_display_name_map : local.code_maps.to_short[k]]
}
