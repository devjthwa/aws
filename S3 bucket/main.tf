resource "aws_s3_bucket" "devopsbucket" {
  bucket = "devop-weltec"
  
  tags = {
    Name        = "devop-weltec"
    Environment = "Dev"
  }  
}

resource "aws_s3_account_public_access_block" "devopsbucket" {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true 
}

resource "aws_s3_bucket_versioning" "devopsbucket" {
    bucket = aws_s3_bucket.devopsbucket.id
    versioning_configuration {
        status = "Enabled"
    }
}
