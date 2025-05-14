provider "aws" {
  region = var.aws_region
}

# Lambda function
resource "aws_lambda_function" "telegram_bot" {
  function_name    = var.function_name
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 10
  
  environment {
    variables = {
      TOKEN      = var.telegram_token
      MY_CHAT_ID = var.telegram_chat_id
    }
  }
  
  role = aws_iam_role.lambda_role.arn
}

# Function URL for Lambda
resource "aws_lambda_function_url" "telegram_bot_url" {
  function_name      = aws_lambda_function.telegram_bot.function_name
  authorization_type = "NONE"
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Basic execution permissions for Lambda
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# CloudWatch logs for Lambda
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
}

# Output the function URL
output "function_url" {
  value = aws_lambda_function_url.telegram_bot_url.function_url
}