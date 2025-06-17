#!/bin/bash
# Usage: init.sh NEW_HOSTNAME

if [ -z "$1" ]; then
  echo "Usage: $0 NEW_HOSTNAME"
  exit 1
fi

NEW_HOST="$1"
echo "Setting hostname to $NEW_HOST"
hostnamectl set-hostname "$NEW_HOST"

# Update /etc/hosts
if grep -q '^127\.0\.1\.1' /etc/hosts; then
  sed -i "s/^127\.0\.1\.1.*/127.0.1.1 $NEW_HOST/" /etc/hosts
else
  echo "127.0.1.1 $NEW_HOST" >> /etc/hosts
fi

# Registration logic (example placeholder)
echo "Registering with CyberArk..."
# /opt/sia/register_connector.sh or API call here
