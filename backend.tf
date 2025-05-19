terraform {
  backend "s3" {
    bucket         = "omer-state-tf"
    key            = "telegram_bot_zoom/terraform.tfstate"
    region         = "us-east-1"
  }
}