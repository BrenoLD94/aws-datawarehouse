resource "aws_s3_bucket" "bucket_raw" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
  }
}

resource "aws_s3_object" "bucket_object" {
    for_each = fileset("../dados/", "*")
    bucket = aws_s3_bucket.bucket_raw.id
    key    = "dados/${each.value}"
    source = "../dados/${each.value}"
    etag = filemd5("../dados/${each.value}")
}