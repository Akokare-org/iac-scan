variable "environment" {
  default = "dev"
}

variable "region" {
  default = "eu-west-1"
}

variable "default_tags" {
  description = "Mandatory tags all supported resources."
  type        = map(string)
  default = {
    "Adobe.Owner"      = "Adobe Stock"
    "Adobe.CostCenter" = "102482"
    "Adobe.PCIData"    = "false"
    "Microservice"     = "Hackathon"
    "Team"             = "stock"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    dev   = "Dev"
    stage = "Stage"
    prod  = "Production"
  }
}

variable "ec2_instances" {
  description = "Test instance for IAC Hackathon"
  default = {
    dev = {
        instance_count   = 1
        instance_type    = "t3.small"
        ami              = "ami-0907d1474a9998a59"
        root_volume_size = 12
    },
  }
}
