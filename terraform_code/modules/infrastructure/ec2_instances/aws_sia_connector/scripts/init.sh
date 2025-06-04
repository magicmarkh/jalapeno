#!/bin/bash
# Usage: init.sh NEW_HOSTNAME
set -e

# 1) rename
/tmp/rename-hostname.sh "$1"

# 2) register with CyberArk
#/tmp/register-sia-connector.sh
