#!/bin/bash

# Test and reload authapp systemd service
sudo systemctl daemon-reload
sudo systemctl enable authapp
sudo systemctl restart authapp

echo "✅ systemd service 'authapp' created and started."


# Test and reload NGINX
sudo nginx -t
sudo systemctl restart nginx

echo "✅ NGINX reverse proxy configured."
