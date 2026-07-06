resource "aws_s3_bucket" "this" {
  count  = length(var.s3_buckets_list)
  bucket = var.s3_buckets_list[count.index]

  tags = {
    Name = var.s3_buckets_list[count.index]
  }
}
