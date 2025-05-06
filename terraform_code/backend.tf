terraform {
  backend "s3" {
    bucket  = "us-ent-east"        # defined in variables.tf
    key     = "terraform/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}
