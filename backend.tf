terraform {
  backend "s3" {
    key            = "telegram_bot_zoom/terraform.tfstate"
    region         = "us-east-1"
  }
}