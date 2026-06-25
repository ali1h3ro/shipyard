#!/usr/bin/env bash
set -euo pipefail

echo "Installing Shipyard..."

if [ ! -f "shipyard" ]; then
  echo "Missing shipyard launcher. Run this script from the repository root."
  exit 1
fi

sudo mkdir -p /opt/shipyard
sudo mkdir -p /etc/deploy-sites
sudo mkdir -p /var/log/shipyard

sudo cp -R bin lib templates VERSION /opt/shipyard/
sudo cp shipyard /usr/local/bin/shipyard

sudo chmod +x /usr/local/bin/shipyard
sudo chmod +x /opt/shipyard/bin/*

echo ""
echo "Shipyard installed successfully."
echo ""
echo "Try:"
echo "  shipyard help"
echo "  shipyard version"
