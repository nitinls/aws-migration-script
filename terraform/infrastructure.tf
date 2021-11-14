provider "aws" {
  region = var.region
  shared_credentials_file = "$HOME/.aws/credentials"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket  = "lift-and-shift-outsource"
    region  = "ap-south-1"
    encrypt = true
    key     = "dev/terraform.tfstate"
    access_key = "AKIAWG46QWYD6WMQ4XGE"
    secret_key = "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"

  }
}

resource "aws_key_pair" "deploy" {
  key_name   = "${var.project}_deploy_key"
  public_key = file("~/.ssh/id_rsa.pub")
}