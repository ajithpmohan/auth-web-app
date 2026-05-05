#!/bin/bash
# This script sets up the systemd service for Next.js app

SERVICE_FILE="/etc/systemd/system/authapp.service"

echo "Creating systemd service for Auth App..."

sudo tee $SERVICE_FILE > /dev/null <<EOF
[Unit]
Description=Next.js Application
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=ubuntu
Group=ubuntu
Environment=HOME=/home/ubuntu
WorkingDirectory=/home/ubuntu/app

# --- Environment ---
Environment=NODE_ENV=production
Environment=PORT=3000

# Optional env file (won’t fail if missing)
EnvironmentFile=/home/ubuntu/app/.env

# Run Next.js directly (better than npm)
ExecStart=/usr/bin/node node_modules/.bin/next start

# --- Restart Policy ---
Restart=always
RestartSec=5

# --- Logging ---
StandardOutput=append:/home/ubuntu/logs/access.log
StandardError=append:/home/ubuntu/logs/error.log

# --- Security / Limits ---
NoNewPrivileges=true
LimitNOFILE=50000

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable authapp
sudo systemctl restart authapp

echo "✅ systemd service 'authapp' created and started."
