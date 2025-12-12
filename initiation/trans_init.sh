#!/bin/bash
set -e
usermod -aG sudo $@
apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)
apt update
apt upgrade -y
apt install vim -y
apt install tree -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
# Add Docker's official GPG key:
apt update
apt install ca-certificates curl -y 
install -m 0755 -d /etc/apt/keyrings 
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc 
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

rm ./google-chrome-stable_current_amd64.deb
apt update
VERSION_STRING=5:29.1.1-1~debian.13~trixie
apt install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin -y
usermod -aG docker $@
