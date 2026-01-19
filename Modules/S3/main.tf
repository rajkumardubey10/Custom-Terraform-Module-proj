### Creating the Bucket 
resource "aws_s3_bucket" "buck" {
    bucket = var.s3_bucket_name
  
}

## Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "pub" {
  bucket = aws_s3_bucket.buck.id

  block_public_acls       = var.s3_bucket_public_access
  block_public_policy     = var.s3_bucket_public_access
  ignore_public_acls      = var.s3_bucket_public_access
  restrict_public_buckets = var.s3_bucket_public_access
}

## Bucket Versioning 
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.buck.id

  versioning_configuration {
    status = var.s3_bucket_versioning ? "Enabled" : "Suspended"
  }

}

## Bucket Ownership
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.buck.id

  rule {
    object_ownership = var.s3_bucket_object_ownership
  }
}

## Bucket Server-Side-Encryption and Bucket Key Permssion
resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = aws_s3_bucket.buck.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.s3_bucket_key_ecryption
    }

    bucket_key_enabled = var.s3_bucket_key_permission
  }

  
}

