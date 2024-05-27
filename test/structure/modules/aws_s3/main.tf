terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dms_s3_endpoint" "s3" {
  endpoint_id = var.endpoint_id
  endpoint_type = var.endpoint_type
  encoding_type = var.encoding_type
  bucket_name = var.bucket_name
  service_access_role_arn = var.service_access_role_arn
  depends_on = var.depends_on
}