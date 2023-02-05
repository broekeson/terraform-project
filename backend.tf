terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "starlight-tfstate-0223"
    key            = "starlight-tfstate-0223"
    dynamodb_table = "state-lock"
    encrypt        = true
  }
}