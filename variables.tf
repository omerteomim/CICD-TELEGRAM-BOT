variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "telegram-zoom-bot1"
}

variable "lambda_zip_path" {
  description = "Path to the Lambda deployment package"
  type        = string
  default     = "lambda_function.zip"
}

variable "telegram_token" {
  description = "Telegram bot token"
  type        = string
  sensitive   = true
}

variable "telegram_chat_id" {
  description = "Your personal Telegram chat ID"
  type        = string
  sensitive   = true
}

variable "s3_bucket"{
  description = "Your personal backend s3 bucket"
  type = string
}
