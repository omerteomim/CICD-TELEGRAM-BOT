terraform {
  backend "s3" {
    bucket         = var.s3_bucket
    key            = "telegram_bot_zoom/terraform.tfstate"
    region         = "us-east-1"
  }
}