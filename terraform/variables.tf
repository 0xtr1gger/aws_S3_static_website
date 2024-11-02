variable "aws_region" {
  description = "The AWS region to deploy the website to"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "random-chaotic-3095802490"
}