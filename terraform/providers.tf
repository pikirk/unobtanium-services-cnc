provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {}
}