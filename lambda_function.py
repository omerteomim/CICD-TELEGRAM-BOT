import json
import os
import re
import requests

# Your personal Telegram chat ID to receive forwarded links
MY_CHAT_ID = os.environ.get("MY_CHAT_ID")

TOKEN = os.environ.get("TOKEN")

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))
    
    body = {}
    if "body" in event:
        if isinstance(event["body"], str):
            body = json.loads(event["body"])
        else:
            body = event["body"]
    message = body.get("message", {})
    text = message.get("text", "")
    chat = message.get("chat", {})
    chat_id = chat.get("id")

    if text:
        zoom_links = re.findall(r'https://admin-ort-org-il\.zoom\.us/rec/share/[^\s]+', text)
        if zoom_links and MY_CHAT_ID:
            for link in zoom_links:
                response = requests.post(
                    f"https://api.telegram.org/bot{TOKEN}/sendMessage",
                    json={"chat_id": MY_CHAT_ID, "text": f"Zoom link detected: {link}"}
                )
                print("Telegram response:", response.text)

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps('OK')
    }