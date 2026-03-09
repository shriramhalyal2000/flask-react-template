#!/bin/bash

set -e

echo "Starting deployment..."

APP_DIR=/var/www/flask-react-app
FRONTEND_DIR=$APP_DIR/frontend
BACKEND_DIR=$APP_DIR/backend

echo "Navigating to app directory"
cd $APP_DIR

echo "Pulling latest code from GitHub"
git pull origin main

echo "Building React frontend"
cd $FRONTEND_DIR
npm ci
npm run build

echo "Copying build to Nginx web directory"
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/

echo "Setting up Python backend"
cd $BACKEND_DIR

python3 -m venv venv
source venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

echo "Restarting backend service"

pkill -f gunicorn || true

gunicorn --bind unix:/tmp/app.sock app:app --daemon

echo "Reloading Nginx"

sudo nginx -s reload

echo "Deployment successful!"