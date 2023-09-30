// Before Adding AWS provider install AWS CLI and configure AWS CLI
// ADD Secret Key,Access Key and Region 
// Adding AWS provider

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

// Adding Region
 
provider "aws" {
  region = "ap-south-1"
}
