locals {
  org        = "unobtanium"
  domain     = "lambda"
  aws_region = "us-east-1"

  # Environment suffix (dev|stage|prod) is provided via var.env.
  env = var.env
  stack_name  = "engraver-handler"

  tags = {
    org        = local.org
    domain     = local.domain
    env        = local.env
    stack      = local.stack_name
    managed-by = "terraform"
  }
}