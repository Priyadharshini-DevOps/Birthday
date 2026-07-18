provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Birthday-3Tier-App"
      Environment = "Dev"
      ManagedBy   = "Terraform"
    }
  }
}