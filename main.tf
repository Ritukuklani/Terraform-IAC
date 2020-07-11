provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0b1e2eeb33ce3d66f"
  instance_type = "t2.micro"
//  # We specify the subnet id in a AWS instance when we want to launch the instance in a particular VPC
//  subnet_id     = aws_subnet.My_VPC_Subnet.id
}
//
//resource "aws_s3_bucket" "terraform_state" {
//  bucket = "terraform-learning-state-bucket-123456789012"
//  # Enable versioning so we can see the full revision history of our
//  # state files
//  versioning {
//    enabled = true
//  }
//  # Enable server-side encryption by default
//  server_side_encryption_configuration {
//    rule {
//      apply_server_side_encryption_by_default {
//        sse_algorithm = "AES256"
//      }
//    }
//  }
//}
//
//resource "aws_dynamodb_table" "terraform_locks" {
//  name         = "terraform-up-and-running-locks-final"
//  billing_mode = "PAY_PER_REQUEST"
//  hash_key     = "LockID"
//  attribute {
//    name = "LockID"
//    type = "S"
//  }
//}
//
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-learning-state-bucket-123456789012"
    key            = "workspaces-example/terraform.tfstate"
    region         = "us-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-final"
    encrypt        = true
  }
}
//
//output "s3_bucket_arn" {
//  value       = aws_s3_bucket.terraform_state.arn
//  description = "The ARN of the S3 bucket"
//}
//output "dynamodb_table_name" {
//  value       = aws_dynamodb_table.terraform_locks.name
//  description = "The name of the DynamoDB table"
//}
