provider "aws" {
  region = var.region
  profile = "stock-dev"
  default_tags {
    tags = {
      "Adobe.Owner"      = "Adobe Stock"
      "Adobe.CostCenter" = "000000"
      "Adobe.PCIData"    = "false"
      "Team"             = "stock"
      "Microservice"     = "stock-web"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "stock-global-tf-states-${var.environment}"
    key    = "tf-as-vpc/${var.region}.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "stock-global-tf-states-${var.environment}"
    key    = "tf-aws-global/global.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "region" {
  backend = "s3"
  config = {
    bucket = "stock-global-tf-states-${var.environment}"
    key    = "tf-aws-region/${var.region}.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "infra_services" {
  backend = "s3"
  config = {
    bucket = "stock-global-tf-states-${var.environment}"
    key    = "tf-as-infra-services/${var.region}.tfstate"
    region = "eu-west-1"
  }
}
