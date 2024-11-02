output "website_url" {
  description = "The URL of the static website"
  value       = aws_s3_bucket.s3_website.website
}