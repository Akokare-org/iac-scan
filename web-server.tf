# Security Group
resource "aws_security_group" "iac_scan_hackathon" {
  description = "Hackathon IAC-Scan Security Group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.as_vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.infra_services.outputs.bastion_security_group_id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = compact(flatten([data.terraform_remote_state.vpc.outputs.as_vpc_cidr_block]))
  }

  tags = {
    "Name"              = "iac-scan-hackthon"
    "Adobe.ArchPath"    = "Stock.Hackathon.Compute.SecurityGroup"
    "Adobe.Environment" = var.environment_tags[var.environment]
  }
}

# EC2 Instance
module "iac_scan_hackathon" {
  source = "git::ssh://git@git.corp.adobe.com/stock-ops/tf-stock-modules.git//web_instance?ref=web_instance-0.3.0"

  name                 = "iac-scan-hackathon"
  environment          = var.environment
  image_id             = var.ec2_instances[var.environment]["ami"]
  instance_count       = var.ec2_instances[var.environment]["instance_count"]
  instance_type        = var.ec2_instances[var.environment]["instance_type"]
  root_volume_size     = var.ec2_instances[var.environment]["root_volume_size"]
  subnet_ids           = flatten(data.terraform_remote_state.vpc.outputs.as_vpc_private_subnet_ids)
  side                 = "a"
  default_tags         = var.default_tags

  security_groups = [
    aws_security_group.iac_scan_hackathon.id,
  ]
}
