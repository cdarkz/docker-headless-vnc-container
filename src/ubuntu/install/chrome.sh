#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Setup Debian Bookworm deb repo"
apt-get update
apt-get install -y ca-certificates debian-archive-keyring
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://deb.debian.org/debian bullseye main' | tee /etc/apt/sources.list.d/debian-bullseye.list
cat <<'EOF' | tee /etc/apt/preferences.d/debian-pin
Package: *
Pin: release n=bullseye
Pin-Priority: 100
EOF

echo "Install Chromium Browser"
apt-get update
apt-get install -y -t bullseye chromium
ln -sfn /usr/bin/chromium /usr/bin/chromium-browser
apt-get clean -y

echo "Remove Debian Bullseye deb repo"
rm -f /etc/apt/sources.list.d/debian-bullseye.list
rm -f /etc/apt/preferences.d/debian-pin
apt-get update
# apt-get install -y --allow-downgrades libdbus-1-3=1.12.20-2ubuntu4.1
