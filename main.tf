terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Proves Spacelift assumed the AWS role and is acting against the account.
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_s3_buckets" "all" {}

output "assumed_role_arn" {
  description = "The AWS identity Spacelift assumed via the cloud integration"
  value       = data.aws_caller_identity.current.arn
}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "region" {
  value = data.aws_region.current.name
}
output "visible_bucket_count" {
  description = "Number of S3 buckets the assumed role can list (proves real read access)"
  value       = length(data.aws_s3_buckets.all.buckets)
}
