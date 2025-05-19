# Telegram Zoom Link Forwarder

A simple Telegram bot that monitors messages for Zoom recording links and forwards them to your personal chat. The bot is deployed as an AWS Lambda function using Terraform and GitHub Actions.

## Overview

This bot automatically detects messages containing Zoom recording links (specifically from `admin-ort-org-il.zoom.us/rec/share/`) in any chat where the bot is present, and forwards these links to your personal Telegram chat. This is useful for keeping track of important Zoom recordings without having to manually check all your group chats.

## Architecture

- **AWS Lambda**: Serverless function that processes Telegram webhook events
- **Terraform**: Infrastructure as Code for consistent AWS resource deployment
- **GitHub Actions**: CI/CD pipeline for automated deployment

## Prerequisites

- AWS Account
- Telegram Bot (created via [@BotFather](https://t.me/BotFather))
- GitHub account (for deployment using GitHub Actions)

## Setup Instructions

### 1. Create a Telegram Bot

1. Start a chat with [@BotFather](https://t.me/BotFather) on Telegram
2. Send `/newbot` and follow the instructions to create a new bot
3. Save the API token provided by BotFather

### 2. Get Your Telegram Chat ID

1. Start a chat with [@userinfobot](https://t.me/userinfobot) on Telegram
2. The bot will reply with your chat ID (a number)

### 3. Set Up GitHub Repository

1. Fork or clone this repository to your GitHub account
2. Add the following secrets in your GitHub repository settings:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
   - `AWS_REGION`: Your preferred AWS region (e.g., `us-east-1`)
   - `TELEGRAM_TOKEN`: The token provided by BotFather
   - `TELEGRAM_CHAT_ID`: Your personal chat ID

### 4. Deploy the Bot

The bot will be automatically deployed when you push changes to the `main` branch, or you can manually trigger the workflow from the GitHub Actions tab.

### 5. Add the Bot to Telegram Groups

Once deployed, add your bot to any Telegram groups where you want to monitor for Zoom links.

## Local Development

### Prerequisites

- Python 3.9+
- Terraform
- AWS CLI configured with your credentials

### Setup

1. Clone the repository
```bash
git clone <your-repo-url>
cd <repo-directory>
```

2. Install dependencies
```bash
pip install requests
```

3. Create a `.env` file with your configuration
```
TELEGRAM_TOKEN=your_bot_token
TELEGRAM_CHAT_ID=your_chat_id
AWS_REGION=your_aws_region
```

4. Test locally (optional)
```bash
python lambda_function.py
```

5. Deploy manually with Terraform
```bash
terraform init
terraform apply -var="telegram_token=your_bot_token" -var="telegram_chat_id=your_chat_id" -var="aws_region=your_aws_region"
```

## Project Structure

- `lambda_function.py`: The Lambda function that processes Telegram webhook events
- `main.tf`: Terraform configuration for AWS resources
- `variables.tf`: Variable definitions for Terraform
- `.github/workflows/deploy.yaml`: GitHub Actions workflow for CI/CD

## Customization

### Modifying the Regex Pattern

The bot currently detects links matching the pattern `https://admin-ort-org-il\.zoom\.us/rec/share/[^\s]+`. To detect different link patterns, modify the regex in `lambda_function.py`:

```python
zoom_links = re.findall(r'your_custom_pattern', text)
```

### Changing AWS Region

Update the default AWS region in `variables.tf` or set it during deployment.

## Troubleshooting

### Webhook Issues

If the webhook setup fails during deployment, you can manually set it:

```bash
curl -X POST https://api.telegram.org/bot<YOUR_TOKEN>/setWebhook?url=<FUNCTION_URL>
```

To check the current webhook status:

```bash
curl --request GET --url https://api.telegram.org/bot<YOUR_TOKEN>/getWebhookInfo
```

### Lambda Function Logs

Check CloudWatch Logs for detailed Lambda execution logs at:
`/aws/lambda/telegram-zoom-bot`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
