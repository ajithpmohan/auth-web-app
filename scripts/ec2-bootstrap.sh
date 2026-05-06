#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt-get update -y

echo "=== Configuring swap (for low-memory instances) ==="

if [ ! -f /swapfile ]; then
  sudo fallocate -l 2G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

echo "=== Installing Node.js (system-wide) ==="
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
sudo apt-get install -y nodejs build-essential

echo "=== Setting ownership ==="
sudo chown -R ubuntu:ubuntu /home/ubuntu/app

echo "=== Installing dependencies & build (as ubuntu) ==="
cd /home/ubuntu/app

rm -rf node_modules .next
npm ci
npm run build

echo "=== Final ownership fix ==="
sudo chown -R ubuntu:ubuntu /home/ubuntu/app

echo "=== Done ==="
