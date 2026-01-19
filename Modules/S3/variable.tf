variable "s3_bucket_name" {
  type = string
  description = "we give the bucket name for s3"
}

variable "s3_bucket_public_access" {
  type = bool
  description = "We give the value for the s3 bucket that whether to give the premission of public access"
  default = true
}

variable "s3_bucket_versioning" {
  type = string
  description = "We give the value for enabling the s3 bucket versioning"
}

variable "s3_bucket_object_ownership" {
  type = string
  description = "we put the value of bucket object ownership"
  default = "BucketOwnerEnforced"
}

variable "s3_bucket_key_ecryption" {
  type = string
  description = "we putting the key encryption for data file inside the s3 bucket"
  default = "AES256"
}

variable "s3_bucket_key_permission" {
  type = bool
  description = "Using an S3 Bucket Key for SSE-KMS reduces encryption costs by lowering calls to AWS KMS. S3 Bucket Keys aren't supported for DSSE-KMS."
  default = true
}



