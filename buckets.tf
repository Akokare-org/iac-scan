# S3 Bucket
module "iac_scan_hackthon" {
  source                    = "git::ssh://git@git.corp.adobe.com/stock-ops/tf-stock-modules.git//s3_bucket?ref=terraform-1.2"
  name                      = "iac-scan-hackathon"
  default_tags              = var.default_tags
  enable_s3_block_public_access = false
}
