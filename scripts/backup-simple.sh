#!/bin/bash
echo "🔧 Starting PostgreSQL backup..."
BACKUP_DIR="/home/ubuntu/backups"
mkdir -p $BACKUP_DIR

# Создадим бэкап
kubectl exec deployment/postgres -- pg_dump -U myuser mydatabase > $BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql

if [ $? -eq 0 ]; then
    echo "✅ Backup created successfully"
    ls -la $BACKUP_DIR/*.sql | tail -5
else
    echo "❌ Backup failed"
fi
