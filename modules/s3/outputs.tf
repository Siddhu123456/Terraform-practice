output "s3_bucket_ids" {
  description = "S3_Bucket_IDs"
  value = [
    for bucket in aws_s3_bucket.this :
    bucket.id
  ]
}