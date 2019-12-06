locals {
  iam_tier = "${var.tier}-*"
}

module "serverless" {
  # Uncomment to test locally
  # source = "../../../../../../terraform-aws-serverless//"

  source  = "FormidableLabs/serverless/aws"
  version = "0.8.6"

  region           = var.region
  service_name     = var.service_name
  stage            = var.tier
  iam_stage        = local.iam_tier
  iam_region       = var.region
  opt_many_lambdas = true
}

module "serverless_xray" {
  # Uncomment to test locally
  # source = "../../../../../../terraform-aws-serverless//modules/xray"

  source  = "FormidableLabs/serverless/aws//modules/xray"
  version = "0.8.6"

  region       = var.region
  service_name = var.service_name
  stage        = var.tier
  iam_stage    = local.iam_tier
  iam_region   = var.region
}

module "serverless_canary" {
  # Uncomment to test locally
  # source = "../../../../../../terraform-aws-serverless//modules/canary"

  source  = "FormidableLabs/serverless/aws//modules/canary"
  version = "0.8.6"

  region       = var.region
  service_name = var.service_name
  stage        = var.tier
  iam_stage    = local.iam_tier
  iam_region   = var.region
}
