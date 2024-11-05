terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-s3-bucket-129102938038"  # Replace with your actual bucket name
    key            = "terraform.tfstate"  # Path inside the S3 bucket for storing the state file
    region         = "us-east-1"          # Specify the AWS region
    encrypt        = true                # Enable encryption for the state file in S3
  }
}