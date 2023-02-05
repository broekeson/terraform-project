#Variable for Provider
variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

#Variable for bucket
variable "bucket" {
  description = "Name of the S3 bucket"
  default     = "starlight-tfstate-0223"
}

#Variable for kms_key_id
variable "kms_key_id" {
  description = "KMS key ID to use for bucket encryption"
  default     = ""
}


variable "bucket_tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(any)
  default = {
    Name        = "State Bucket"
    Environment = "Dev"
  }
}

#Variable for dynamodb_table
variable "dynamodb_table" {
  description = "Name of the DynamoDB table"
  default     = "state-lock"
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. The default value is PROVISIONED."
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = "The maximum number of strongly consistent reads consumed per second before DynamoDB returns a ThrottlingException. For PAY_PER_REQUEST billing mode, do not set this field."
  default     = 1
}

variable "write_capacity" {
  description = "The maximum number of writes consumed per second before DynamoDB returns a ThrottlingException. For PAY_PER_REQUEST billing mode, do not set this field."
  default     = 1
}

variable "hash_key" {
  description = "The name of the hash key."
  default     = "LockID"
}

variable "range_key" {
  description = "The name of the range key."
  default     = ""
}

variable "attribute" {
  description = "A list of attributes that describe the key schema for the table and indexes. Each attribute in the list is a map, with the following keys:"
  type        = map(any)
  default = {
    name = "LockID"
    type = "S"
  }
}

variable "dynamodb_table_tags" {
  description = "A mapping of tags to assign to the table."
  type        = map(any)
  default = {
    Name        = "State Lock"
    Environment = "Dev"
  }
}

variable "aws_dynamodb_table_enabled" {
  description = "Enable DynamoDB table creation"
  default     = true
}