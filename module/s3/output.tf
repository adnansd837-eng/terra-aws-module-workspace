
output "bucket" {
  value = aws_s3_bucket.my_s3_bucket[*].bucket
}

output "arn" {
  value = aws_s3_bucket.my_s3_bucket[*].arn
}
