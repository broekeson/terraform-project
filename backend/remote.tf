#Providers block
provider "aws" {
  region = var.aws_region
}

#Data source to get caller identity
data "aws_caller_identity" "current" {}

#Create an S3 bucket
resource "aws_s3_bucket" "tfstate-bucket" {
  bucket = var.bucket

  versioning {
    enabled = true
  }

  tags = {
    Name        = "${var.bucket_tags["Name"]}"
    Environment = "${var.bucket_tags["Environment"]}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_id
        sse_algorithm     = "${var.kms_key_id}" == "" ? "AES256" : "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.tfstate-bucket.id
  acl = "private"
}

#Create a DynamoDB table
resource "aws_dynamodb_table" "state-lock" {
  count          = var.aws_dynamodb_table_enabled ? 1 : 0
  name           = var.dynamodb_table
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  attribute {
    name = var.attribute["name"]
    type = var.attribute["type"]
  }

  tags = {
    Name        = "${var.dynamodb_table_tags["Name"]}"
    Environment = "${var.dynamodb_table_tags["Environment"]}"
  }

  lifecycle {
    prevent_destroy = true
  }

}

data "aws_iam_policy_document" "tf_backend_bucket_policy" {
  #Policy for S3 bucket to deny access to all users except the current user
  statement {
    sid    = "1"
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      "${aws_s3_bucket.tfstate-bucket.arn}/*",
      "${aws_s3_bucket.tfstate-bucket.arn}",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = [false, ]
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  #Policy for S3 bucket to allow put object from an encryption key
  statement {
    sid    = "2"
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.tfstate-bucket.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "${var.kms_key_id}" == "" ? "AES256" : "aws:kms"
      ]
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

#Attach the policy to the S3 bucket
resource "aws_s3_bucket_policy" "tf_backend_policy" {
  bucket = aws_s3_bucket.tfstate-bucket.id
  policy = data.aws_iam_policy_document.tf_backend_bucket_policy.json
}