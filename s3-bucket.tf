provider "aws" {
  profile    = "terraform-user"
  access_key = "AKIAVXKEPQ5KEVVA6I7S"
  secret_key = "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"
  region     = "ap-northeast-1"
}
resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket-srinu-9963"
  tags = {
    Name        = "MY BUCKET"
    environment = "test"
  }
}
