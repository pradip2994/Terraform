//Before adding AWS provider install AWS CLI and configure AWS CLI
//ADD Secret Key,Access Key and Region 

//Adding AWS provider

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

// Creating Bucket

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-pkv1" 
}

resource "aws_s3_bucket_ownership_controls" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

//Permission for bucket public Access

resource "aws_s3_bucket_public_access_block" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "my_bucket" {
  depends_on = [
    aws_s3_bucket_public_access_block.my_bucket,
    aws_s3_bucket_ownership_controls.my_bucket,
    ]
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "public-read"
}

//Enabling Versioning

resource "aws_s3_bucket_versioning" "bucket_versoning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
}
}

// Adding Bucket Policy- To provide read-only access 

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_read_only_access.json
}

data "aws_iam_policy_document" "allow_read_only_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["683633011377"] //the principal is an AWS account identified by the account number "683633011377."
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.my_bucket.arn,
      "${aws_s3_bucket.my_bucket.arn}/*",
    ]
  }
}  
