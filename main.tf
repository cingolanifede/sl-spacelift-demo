terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Proves Spacelift assumed the AWS role via the cloud integration.
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

output "assumed_role_arn" {
  description = "The AWS identity Spacelift assumed (proves the cloud integration works)"
  value       = data.aws_caller_identity.current.arn
}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "region" {
  value = data.aws_region.current.name
}
