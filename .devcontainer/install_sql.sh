#!/usr/bin/env bash
set -e

echo "Installing system packages for pyodbc + SQL Server ODBC driver..."

# Codespaces runs this as the vscode user; use sudo for apt writes.
sudo apt-get update

# Core ODBC libs
sudo apt-get install -y \
  unixodbc \
  unixodbc-dev \
  curl \
  gnupg \
  apt-transport-https

# Microsoft repository (Debian 12)
sudo mkdir -p /etc/apt/keyrings
curl -sSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
  | sudo tee /etc/apt/sources.list.d/mssql-release.list > /dev/null

sudo apt-get update

# Install MS SQL ODBC Driver 18 + tools
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18

echo "export PATH=\$PATH:/opt/mssql-tools18/bin" >> ~/.bashrc

echo "✔ SQL Server ODBC driver installed."
