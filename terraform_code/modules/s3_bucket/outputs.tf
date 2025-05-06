output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.secure_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.secure_bucket.arn
}

output "folder_keys" {
  description = "Keys of any folders created"
  value       = [for o in aws_s3_object.folders : o.key]
}
