#!/bin/bash

set -e

echo "Installing required packages..."
sudo apt-get install curl gpg apt-transport-https --yes

echo "Adding Helm GPG key..."
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

echo "Adding Helm repository..."
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" \
  | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

echo "Updating APT..."
sudo apt-get update

echo "Installing Helm..."
sudo apt-get install helm -y

echo "Helm installation complete."
