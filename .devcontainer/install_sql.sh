#!/usr/bin/env bash
set -e

echo "Installing system packages for pyodbc + SQL Server ODBC driver..."

apt-get update

# Core ODBC libs
apt-get install -y \
  unixodbc \
  unixodbc-dev \
  curl \
  gnupg \
  apt-transport-https

# Microsoft repository
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/12/prod.list \
    > /etc/apt/sources.list.d/mssql-release.list

apt-get update

# Install MS SQL ODBC Driver 18 + tools
ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18

echo "export PATH=\$PATH:/opt/mssql-tools18/bin" >> ~/.bashrc

echo "✔ SQL Server ODBC driver installed."
