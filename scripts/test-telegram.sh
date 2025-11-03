#!/bin/bash

TELEGRAM_BOT_TOKEN="8389954032:AAHSjDAhwB_PgBvcNe2zXpwc9WNknvY0bJ4"
TELEGRAM_CHAT_ID="967851087"

curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "{\"chat_id\": \"$TELEGRAM_CHAT_ID\", \"text\": \"✅ Тест алертинга из Kubernetes!\nКластер: 158.160.125.160\nВремя: $(date)\"}" \
    "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

echo "Тестовое сообщение отправлено!"
