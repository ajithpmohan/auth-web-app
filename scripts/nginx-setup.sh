#!/bin/bash
# NGINX reverse proxy setup

echo "=== Installing NGINX ==="
sudo apt-get update -y
sudo apt install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

NGINX_FILE="/etc/nginx/sites-available/authapp-proxy"

echo "Creating NGINX site..."

sudo tee $NGINX_FILE > /dev/null <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_cache_bypass $http_upgrade;

        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}
EOF

# Enable site
sudo ln -sf /etc/nginx/sites-available/authapp-proxy /etc/nginx/sites-enabled/authapp-proxy

# Remove default site if it exists
sudo rm -f /etc/nginx/sites-enabled/default

# Test and reload
sudo nginx -t
sudo systemctl restart nginx

echo "✅ NGINX reverse proxy configured."
