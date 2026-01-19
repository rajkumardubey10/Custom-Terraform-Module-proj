module "my_s3_bucket" {
  source = "./Modules/S3"

  s3_bucket_name = var.client_s3_bucket_name
  s3_bucket_versioning  = var.client_s3_bucket_versioning
  

}

module "my_s3_bucket_1" {
  source = "./Modules/S3"

  s3_bucket_name = var.client_s3_bucket_name_1
  s3_bucket_versioning  = var.client_s3_bucket_versioning

}