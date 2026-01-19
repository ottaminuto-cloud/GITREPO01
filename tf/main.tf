terraform {
  required_version = ">= 1.0.0"

  required_providers{
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0" # modified, original was "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "aws_instances" "all" {

}

data "aws_instance" "details" { 
  for_each = toset(data.aws_instances.all.ids)
  instance_id = each.value
}

output "ec2_instances" {
  value = {
    for id, inst in data.aws_instance.details :
    id => {
      instance_id = inst.id
      name        = inst.tags["Name"]
      type        = inst.instance_type
      state       = inst.instance_state
      private_ip  = inst.private_ip
      public_ip   = inst.public_ip
      az          = inst.availability_zone
    }
  }
}
