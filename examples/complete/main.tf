module "example" {
  source = "../.."

  context = module.this.context
}
