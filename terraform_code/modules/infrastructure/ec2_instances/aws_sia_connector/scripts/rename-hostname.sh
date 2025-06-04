#!/bin/bash
# Usage: rename-hostname.sh NEW_HOSTNAME

if [ -z "$1" ]; then
  echo "Usage: $0 NEW_HOSTNAME"
  exit 1
fi

NEW_HOST="$1"
hostnamectl set-hostname "$NEW_HOST"
# replace or append the 127.0.1.1 entry
if grep -q '^127\.0\.1\.1' /etc/hosts; then
  sed -i "s/^127\.0\.1\.1.*/127.0.1.1 $NEW_HOST/" /etc/hosts
else
  echo "127.0.1.1 $NEW_HOST" >> /etc/hosts
fi
