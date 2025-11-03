#!/bin/bash
VERSION=${1:-latest}
cd /home/ubuntu

echo "🚀 Helm CI/CD Pipeline for version: $VERSION"

# Build and push
echo "1. Building Docker image..."
docker build -t 158.160.120.153:5000/django-app:$VERSION -f /home/ubuntu/app/Dockerfile /home/ubuntu/app

echo "2. Pushing to registry..."
docker push 158.160.120.153:5000/django-app:$VERSION

echo "3. Deploying with Helm..."
cd /home/ubuntu/django-minimal-app
helm upgrade --install minimal-django-app . --set django.image="158.160.120.153:5000/django-app:$VERSION"

echo "✅ Helm deployment completed!"
echo "🌐 Application available at: http://158.160.125.160:30080"
