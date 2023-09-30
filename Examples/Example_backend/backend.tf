// In your Terraform configuration file main.tf, define the remote backend.

terraform {
  backend "s3" {
    bucket         = "pradipkv247" 
    key            = "terraform_state_files/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
