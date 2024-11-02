terraform {
	required_version = ">= 1.9.5"
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 5.0"
		}	
	}
}

provider "aws" {
  region = var.aws_region
}

# creating an S3 bucket
resource "aws_s3_bucket" "s3_website" {
  bucket = var.bucket_name
}

# configuring a static website to be hosten on the bucket
resource "aws_s3_bucket_website_configuration" "s3_website" {
	bucket = aws_s3_bucket.s3_website.bucket
	index_document {
		suffix = "index.html"	
	}
	error_document {
		key = "index.html"
	}
}

# bucket policy for public access to the website
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
		Sid: "PublicReadGetObject",
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_website.arn}/*"
      }
    ]
  })
}

# configuring access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.s3_website.bucket
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# uploading files
resource "aws_s3_object" "upload_files" {
	for_each = fileset("${path.module}/../src", "*")

	bucket = aws_s3_bucket.s3_website.bucket
	key    = each.value
	source = "${path.module}/../src/${each.value}"

	content_type = "text/html"
}