#!/bin/bash

TELEGRAM_BOT_TOKEN="8389954032:AAHSjDAhwB_PgBvcNe2zXpwc9WNknvY0bJ4"
TELEGRAM_CHAT_ID="967851087"

send_alert() {
    local message="🔄 Kubernetes Alert: $1"
    curl -s -X POST \
        -H "Content-Type: application/json" \
        -d "{\"chat_id\": \"$TELEGRAM_CHAT_ID\", \"text\": \"$message\"}" \
        "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" > /dev/null
    echo "Alert sent: $1"
}

# Проверка статуса приложения
APP_STATUS=$(kubectl get pods -l app=django-app -o jsonpath="{.items[0].status.phase}" 2>/dev/null)

if [ "$APP_STATUS" != "Running" ]; then
    send_alert "❌ Django приложение упало! Статус: $APP_STATUS"
fi

# Проверка доступности приложения
if ! curl -s --connect-timeout 10 http://158.160.125.160:30080 > /dev/null; then
    send_alert "🌐 Приложение недоступно по http://158.160.125.160:30080"
fi

# Проверка использования памяти
MEM_USAGE=$(free | grep Mem | awk "{printf \"%.1f\", \$3/\$2 * 100.0}")
if [ $(echo "$MEM_USAGE > 85" | bc -l 2>/dev/null) -eq 1 ]; then
    send_alert "💾 Высокая загрузка памяти: ${MEM_USAGE}%"
fi

echo "Проверка завершена в $(date)"
