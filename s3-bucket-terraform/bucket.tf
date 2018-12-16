provider "aws" {
  region = "us-west-2"
}


# Bucket to store terraform state, it must exist before terraform can use s3
# it to store it's state.
# - comment out the `terraform {...}` backend setting block below
# - run `terraform init`
# - run `AWS_PROFILE=prod terraform apply` to create the 2 buckets
resource "aws_s3_bucket" "terraform-state" {
  bucket = "armory-training-terraform-state"
  acl    = "private"
  versioning {
    enabled = true
  }
}

# after creating the bucket, you can now migrate the state to s3 by doing:
# - uncomment out the `terraform {...}` backend setting
# - run `AWS_PROFILE=prod terraform init`
# - answer yes to migrate state into from local to s3
# - now your state is stored in s3!
# =========================
terraform {
  backend "s3" {
    bucket = "armory-training-terraform-state"
    key    = "example-app-state"
    region = "us-west-2"
  }
}


# the bucket to store debians
resource "aws_s3_bucket" "deb-bucket" {
  bucket = "armory-training-deb-repo"
  acl    = "private"

  versioning {
    enabled = true
  }


  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
