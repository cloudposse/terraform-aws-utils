module "example" {
  source = "../.."

  context = module.this.context
}

locals {
  code_maps = module.example.region_az_alt_code_maps
}
