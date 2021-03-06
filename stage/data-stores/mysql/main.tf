provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  password            = "password"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-learning-state-bucket-123456789012"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-final"
    encrypt        = true
  }
}

output "address" {
  value       = aws_db_instance.example.address
  description = "Connect to the database at this endpoint"
}
output "port" {
  value       = aws_db_instance.example.port
  description = "The port the database is listening on"
}