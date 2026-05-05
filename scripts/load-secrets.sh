#!/bin/bash

SECRET_NAME="dev/auth-web-app/env"
ENV_FILE="/home/ubuntu/app/.env"

# Fetch secret JSON
SECRET_JSON=$(aws secretsmanager get-secret-value \
    --secret-id $SECRET_NAME \
    --query SecretString \
    --output text)

# Convert JSON to KEY=value format
echo "$SECRET_JSON" | jq -r 'to_entries | .[] | "\(.key)=\(.value)"' > $ENV_FILE

# --- Fetch EC2 public IP using IMDSv2 ---
# TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
#   -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# DOMAIN=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
#   http://169.254.169.254/latest/meta-data/public-ipv4)

# DOMAIN=$(aws ssm get-parameter \
#     --name "/app/env/alb_dns" \
#     --query "Parameter.Value" \
#     --output text)

# Fix permissions
chown ubuntu:ubuntu $ENV_FILE
chmod 600 $ENV_FILE
