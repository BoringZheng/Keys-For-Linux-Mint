#!/bin/bash

set -euo pipefail

if [[ $EUID -ne 0]]; then
    echo "Please run as root."
    exit 1
fi

cd ./vendor/keyd
make
make install
systemctl enable keyd --now keyd

mkdir -p /etc/keyd

tee /etc/keyd/default.conf > /dev/null << 'EOF'

