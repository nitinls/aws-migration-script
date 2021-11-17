terraform {
  backend "s3" {
    bucket  = "lift-and-shift-outsource"
    region  = "ap-south-1"
    encrypt = true
    key     = "dev/terraform.tfstate"
    access_key = "AKIAWG46QWYDYVPTYBP3"
    secret_key = "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"

  }
}